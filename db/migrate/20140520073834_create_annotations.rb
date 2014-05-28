class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :paragraph_id
      t.string :content
      t.string :color

      t.timestamps
    end
  end
end
