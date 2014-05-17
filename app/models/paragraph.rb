class Paragraph < ActiveRecord::Base

  has_many :contents
  has_one :modifyparagraph
  has_many :resources
  belongs_to :book
  belongs_to :chapter

  after_initialize :set_default_values
  after_save :save_content_resource

  attr_accessor :contentTmp, :parent, :resourceArray, :contentArray


  def text
    self.contents.inject("") {|sum, ele|  sum + ele.text.to_s }
  end

  private
  def set_default_values
    self.contentTmp, self.resourceArray, self.contentArray =
        Content.new, Array.new, Array.new
  end

  def save_content_resource

    self.contentTmp.paragraph_id = self.id
    self.contentTmp.save

    save_array self.contentArray
    save_array self.resourceArray

  end

  def save_array array_val

    @book_font = Hash[self.book.book_fonts.map { |ele| [ele.name, ele.id]}]

    array_val.each do |arr|
      arr.paragraph_id = self.id
      arr.book_font_id = @book_font[arr.book_font_name] unless arr.book_font_name.nil?
      #arr.index = index + 1
      arr.save
    end

  end



end
