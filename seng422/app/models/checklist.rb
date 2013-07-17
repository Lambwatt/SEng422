class Checklist < ActiveRecord::Base
  attr_accessible :cid, :status, :title
	has_many :item
end
