class AddBookFontIdToContent < ActiveRecord::Migration
  def change
    add_column :contents, :book_font_id, :integer
  end
end
