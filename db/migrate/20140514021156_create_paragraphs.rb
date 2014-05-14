class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.integer :book_id
      t.integer :chapter_id
      t.integer :index
      t.integer :is_only_text

      t.timestamps
    end
  end
end
