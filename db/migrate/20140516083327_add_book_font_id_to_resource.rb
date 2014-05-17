class AddBookFontIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :book_font_id, :integer
  end
end
