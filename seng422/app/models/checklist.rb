class Checklist < ActiveRecord::Base
  attr_accessible :status, :title, :lat, :lng, :user_id, :approved, :description, :file, :date
	has_many :items#, :class_name => Item
	belongs_to :user

	accepts_nested_attributes_for :items

 	before_save :default_values
  def default_values
 	 self.approved ||= "false"
  end	
end
