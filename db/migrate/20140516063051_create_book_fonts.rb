class CreateBookFonts < ActiveRecord::Migration
  def change
    create_table :book_fonts do |t|
      t.integer :book_id
      t.string :name
      t.string :family
      t.integer :size
      t.boolean :bold
      t.boolean :italic
      t.boolean :underline
      t.integer :colorR
      t.integer :colorG
      t.integer :colorB
      t.integer :syscolor

      t.timestamps
    end
  end
end
