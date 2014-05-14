class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :paragraph_id
      t.text :text

      t.timestamps
    end
  end
end
