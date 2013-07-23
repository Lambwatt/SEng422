class Checklist < ActiveRecord::Base
  attr_accessible :cid, :status, :title, :lat, :lng, :user_id
	has_many :items#, :class_name => Item
	belongs_to :user
end
