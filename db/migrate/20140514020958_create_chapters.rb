class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :book_id
      t.integer :index
      t.references :parent
      t.integer :degree
      t.string :title

      t.timestamps
    end
  end
end
