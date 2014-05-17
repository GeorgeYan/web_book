class AddBookFontIdToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :book_font_id, :integer
  end
end
