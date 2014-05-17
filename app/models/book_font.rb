class BookFont < ActiveRecord::Base

  belongs_to :book
  has_many :contents
  has_many :chapters
  has_many :resources

end
