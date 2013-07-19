class Item < ActiveRecord::Base
  belongs_to :checklist, :foreign_key => "checklist_id"
  attr_accessible :status, :title
end
