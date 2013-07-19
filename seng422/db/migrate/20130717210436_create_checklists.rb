class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.integer :cid
      t.string :title
      t.string :status
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
