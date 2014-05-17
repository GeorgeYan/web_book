class Content < ActiveRecord::Base

  belongs_to :paragraph
  belongs_to :book_font

end
