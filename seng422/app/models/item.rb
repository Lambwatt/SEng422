class Item < ActiveRecord::Base
  attr_accessible :cid, :status, :title
	belongs_to :checklist
end
