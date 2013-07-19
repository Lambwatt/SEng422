class Checklist < ActiveRecord::Base
  attr_accessible :cid, :status, :title
	has_many :items#, :class_name => Item 
end
