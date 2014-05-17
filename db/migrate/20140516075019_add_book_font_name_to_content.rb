class AddBookFontNameToContent < ActiveRecord::Migration
  def change
    add_column :contents, :book_font_name, :string
  end
end
