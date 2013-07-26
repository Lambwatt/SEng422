require 'net/http'
require 'xmlsimple'

class Checklist < ActiveRecord::Base
  attr_accessible :status, :title, :lat, :lng, :user_id, :approved, :description, :file, :date
	has_many :items#, :class_name => Item
	belongs_to :user

	accepts_nested_attributes_for :items

 	before_save :default_values
  def default_values
		self.status ||= "Unanswered"
 	 	self.approved ||= "false"
  end	

  def add_default_items
	  self.items = Item.create([
		  # Plan title
		  {:section => "Plan Title", :title => "Type of plan"},
		  {:section => "Plan Title", :title => "Legal Description & registered plan no."},
		  {:section => "Plan Title", :title => "BCGS NO."},
		  {:section => "Plan Title", :title => "Appropriate Scale & Bar, including intended plot size"},
		  {:section => "Plan Title", :title => "Legend explaining all symbols and non-standard abbreviations"},
		  {:section => "Plan Title", :title => "Bearing derivation and reference"},
		  {:section => "Plan Title", :title => "Notation: bearings to BTs are magnetic or planned bearings"},
		  {:section => "Plan Title", :title => "North Point"},

		  # Main body of plan
		  {:section => "Main Body", :title => "Appropriate designation for title or Interest parcels (ex Lot Number)"},
		  {:section => "Main Body", :title => "All essential dimensions given and closure calculated"},
		  {:section => "Main Body", :title => "Title & Interest Parcel Area or Volume correct & to required precision-GSI Rule 3"},
		  {:section => "Main Body", :title => "Boundaries reestablished and/or lots divided in accordance with Land Survey Act"},
		  {:section => "Main Body", :title => "Sufficient ties to evidence of previous surveys"},
		  {:section => "Main Body", :title => "Monumentation labeled and correct - GSI Rule 1-2 to 1-7"},
		  {:section => "Main Body", :title => "Read or \"Lane\" and name, when available, where road is being dedicated"},
		  {:section => "Main Body", :title => "Remember to check for hooked parcels, part parcels and remainders"},
		  {:section => "Main Body", :title => "New Dedicated Road or RW fully dimensioned with widths indicated-GSI Rule"},
		  {:section => "Main Body", :title => "No text less than 2mm"},
		  {:section => "Main Body", :title => "Plotting to scale and drafting legible - GSI Rule 3-2 & 3-3"},
		  {:section => "Main Body", :title => "Bold outline 1.0 - 1.5 mm centered on boundary (including any detail drawings)"},
		  {:section => "Main Body", :title => "Existing R/W, Easement or Covenant boundaries shown with broken lines - GSI Rule 3-4"},
		  {:section => "Main Body", :title => "Details of bearing trees and ancillary evidence found and made - GSI Rule 3-4"},
		  {:section => "Main Body", :title => "Radius, arc, radial bearings for each curve point - GSI Rule 3-4"},
		  {:section => "Main Body", :title => "Railway plan in un-surveyed land has district lot number assigned"},
		  {:section => "Main Body", :title => "Access to water body where applicable - LTA s75(1)"},
		  {:section => "Main Body", :title => "Label Un-surveyed Crown Land including theoretical or unsurveyed portions of townships"},

		  # Scenery
		  {:section => "Scenery", :title => "Check status of adjacent roads. Have they all been dedicated?"},
		  {:section => "Scenery", :title => "Parcel boundaries (incl. highway, roads and railway) shown with solid lines - Rule 3-4(2)(g)"},
		  {:section => "Scenery", :title => "Description(s) given for all surrounding lands - GSI Rule 3-4(1)(r)"},
		  {:section => "Scenery", :title => "Primary parcel designations prominent in body of plan (use 'DL' not 'Lot') - Rule 10-14"},
		  {:section => "Scenery", :title => "Existing Road Names shown - GSI Rule 3-4"},
		  {:section => "Scenery", :title => "Roads, Trails, and Seismic Lines shown and labeled with width and posted as required"},
		  {:section => "Scenery", :title => "'Rem' added on lot and \"portion of\" or \"part of\" in title where appropriate"},

		  # Deposit statement
		  {:section => "Deposit Statement", :title => "Plan lies within (Regional District) statement - GSI Rule 3-4"},
		  {:section => "Deposit Statement", :title => "Leave 7 cm 12 cm clear space in top right corner for Registrar's notation pursuant to S 56 LTA"},

		  # Integrated survey area
		  {:section => "Integrated Survey Area", :title => "Grid bearing notation; ISA name and number, datum and bearing derivation - GSI Rule 5-7"},
		  {:section => "Integrated Survey Area", :title => "Control monuments tied in accordance with GSI Rules 5-4(2)"},
		  {:section => "Integrated Survey Area", :title => "Meets accuracy standards of integrated legal survey - GSI Rule 5-4 (3) & (4)"},
		  {:section => "Integrated Survey Area", :title => "Control monuments shown on plan with required symbol and respective designation - GSI Rule 5-7(2)"},

		  # Miscellaneous
		  {:section => "Miscellaneous", :title => "Spelling check"},
		  {:section => "Miscellaneous", :title => "Standard plan size - GSI Rule 3-1"},
		  {:section => "Miscellaneous", :title => "If practical, top of plan orientated north - GSI Rule 3-3(5)"},
		  {:section => "Miscellaneous", :title => "Notation regarding existing records that plan is compiled from."},

		  # Electronic plan
		  {:section => "Electronic Plan", :title => "Plan Image created with Adobe 6.0 or higher with minimum 600 dpi resolution - GSI Rule 3-1 (1)"},
		  {:section => "Electronic Plan", :title => "All plan features black ink on white background with no ornate fonts - GSI Rule 3-3(1)"},
		  {:section => "Electronic Plan", :title => "No signatures on plan - GSI Rule 3-3(7)"},
		  {:section => "Electronic Plan", :title => "Plan complies with all standards for electronic submissions approved by S.G. GSI Rule 3-3 (12)"}
	  ])

	  return save
  end

  def setup
    woeid_url = 'http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text%3D%22' + self.lat.to_s + '%2C' + self.lng.to_s + '%22%20and%20gflags%3D%22R%22'
    woeid_xml = Net::HTTP.get_response(URI.parse(woeid_url)).body
    woeid_data = XmlSimple.xml_in(woeid_xml)

    woeid = woeid_data['results'][0]['Result'][0]['woeid']

    url = 'http://weather.yahooapis.com/forecastrss?w=' + woeid[0] + '&u=c'
    xml = Net::HTTP.get_response(URI.parse(url)).body
    data = XmlSimple.xml_in(xml)

    @week = data['channel'][0]['item'][0]['forecast']
  end
end
