class Checklist < ActiveRecord::Base
  attr_accessible :cid, :status, :title, :lat, :lng
	has_many :item
end
