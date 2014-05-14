class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :paragraph_id
      t.integer :index
      t.string :location
      t.string :rtype

      t.timestamps
    end
  end
end
