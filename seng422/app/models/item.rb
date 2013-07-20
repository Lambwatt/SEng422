class Item < ActiveRecord::Base
  belongs_to :checklist, :foreign_key => "checklist_id"
  attr_accessible :status, :title

	before_save :default_values
  def default_values
    self.status ||= "unanswered"
  end
end
