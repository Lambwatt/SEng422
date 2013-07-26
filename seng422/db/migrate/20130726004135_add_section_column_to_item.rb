class AddSectionColumnToItem < ActiveRecord::Migration
  def change
	  add_column :items, :section, :string
  end
end
