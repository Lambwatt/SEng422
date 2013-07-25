class Checklist < ActiveRecord::Base
  attr_accessible :cid, :status, :title, :lat, :lng, :user_id, :items
	has_many :items#, :class_name => Item
	belongs_to :user

	accepts_nested_attributes_for :items
end
