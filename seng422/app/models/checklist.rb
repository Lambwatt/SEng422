class Checklist < ActiveRecord::Base
  attr_accessible :cid, :status, :title, :lat, :lng
	has_many :items#, :class_name => Item
end
