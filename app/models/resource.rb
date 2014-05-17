class Resource < ActiveRecord::Base

  belongs_to :paragraph
  belongs_to :book_font

  attr_accessor :font_name

  alias :book_font_name :font_name

end
