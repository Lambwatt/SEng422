class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :title
      t.string :status
      t.decimal :lat
      t.decimal :lng
			t.boolean :approved

      t.timestamps
    end
  end
end
