class CreateModifyparagraphs < ActiveRecord::Migration
  def change
    create_table :modifyparagraphs do |t|
      t.integer :book_id
      t.integer :chapter_id
      t.integer :prev_id
      t.integer :next_id
      t.text :content

      t.timestamps
    end
  end
end
