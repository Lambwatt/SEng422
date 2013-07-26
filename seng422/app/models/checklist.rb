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
		  {:title => "Type of plan"},
		  {:title => "Legal Description & registered plan no."},
		  {:title => "BCGS NO."},
		  {:title => "Appropriate Scale & Bar, including intended plot size"},
		  {:title => "Legend explaining all symbols and non-standard abbreviations"},
		  {:title => "Bearing derivation and reference"},
		  {:title => "Notation: bearings to BTs are magnetic or planned bearings"},
		  {:title => "North Point"},

		  # Main body of plan
		  {:title => "Appropriate designation for title or Interest parcels (ex Lot Number)"},
		  {:title => "All essential dimensions given and closure calculated"},
		  {:title => "Title & Interest Parcel Area or Volume correct & to required precision-GSI Rule 3"},
		  {:title => "Boundaries reestablished and/or lots divided in accordance with Land Survey Act"},
		  {:title => "Sufficient ties to evidence of previous surveys"},
		  {:title => "Monumentation labeled and correct - GSI Rule 1-2 to 1-7"},
		  {:title => "Read or \"Lane\" and name, when available, where road is being dedicated"},
		  {:title => "Remember to check for hooked parcels, part parcels and remainders"},
		  {:title => "New Dedicated Road or RW fully dimensioned with widths indicated-GSI Rule"},
		  {:title => "No text less than 2mm"},
		  {:title => "Plotting to scale and drafting legible - GSI Rule 3-2 & 3-3"},
		  {:title => "Bold outline 1.0 - 1.5 mm centered on boundary (including any detail drawings)"},
		  {:title => "Existing R/W, Easement or Covenant boundaries shown with broken lines - GSI Rule 3-4"},
		  {:title => "Details of bearing trees and ancillary evidence found and made - GSI Rule 3-4"},
		  {:title => "Radius, arc, radial bearings for each curve point - GSI Rule 3-4"},
		  {:title => "Railway plan in un-surveyed land has district lot number assigned"},
		  {:title => "Access to water body where applicable - LTA s75(1)"},
		  {:title => "Label Un-surveyed Crown Land including theoretical or unsurveyed portions of townships"},

		  # Scenery
		  {:title => "Check status of adjacent roads. Have they all been dedicated?"},
		  {:title => "Parcel boundaries (incl. highway, roads and railway) shown with solid lines - Rule 3-4(2)(g)"},
		  {:title => "Description(s) given for all surrounding lands - GSI Rule 3-4(1)(r)"},
		  {:title => "Primary parcel designations prominent in body of plan (use 'DL' not 'Lot') - Rule 10-14"},
		  {:title => "Existing Road Names shown - GSI Rule 3-4"},
		  {:title => "Roads, Trails, and Seismic Lines shown and labeled with width and posted as required"},
		  {:title => "'Rem' added on lot and \"portion of\" or \"part of\" in title where appropriate"},

		  # Deposit statement
		  {:title => "Plan lies within (Regional District) statement - GSI Rule 3-4"},
		  {:title => "Leave 7 cm 12 cm clear space in top right corner for Registrar's notation pursuant to S 56 LTA"},

		  # Integrated survey area
		  {:title => "Grid bearing notation; ISA name and number, datum and bearing derivation - GSI Rule 5-7"},
		  {:title => "Control monuments tied in accordance with GSI Rules 5-4(2)"},
		  {:title => "Meets accuracy standards of integrated legal survey - GSI Rule 5-4 (3) & (4)"},
		  {:title => "Control monuments shown on plan with required symbol and respective designation - GSI Rule 5-7(2)"},

		  # Miscellaneous
		  {:title => "Spelling check"},
		  {:title => "Standard plan size - GSI Rule 3-1"},
		  {:title => "If practical, top of plan orientated north - GSI Rule 3-3(5)"},
		  {:title => "Notation regarding existing records that plan is compiled from."},

		  # Electronic plan
		  {:title => "Plan Image created with Adobe 6.0 or higher with minimum 600 dpi resolution - GSI Rule 3-1 (1)"},
		  {:title => "All plan features black ink on white background with no ornate fonts - GSI Rule 3-3(1)"},
		  {:title => "No signatures on plan - GSI Rule 3-3(7)"},
		  {:title => "Plan complies with all standards for electronic submissions approved by S.G. GSI Rule 3-3 (12)"}
	  ])

	  return save
  end
end
