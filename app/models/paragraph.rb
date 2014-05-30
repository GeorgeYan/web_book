class Paragraph < ActiveRecord::Base

  has_one :content
  has_one :modifyparagraph
  has_many :resources
  has_many :annotation
  belongs_to :book
  belongs_to :chapter

  after_initialize :set_default_values
  after_save :save_content_resource

  attr_accessor :contentTmp, :parent, :resourceArray

  def text= text
    self.contentTmp.text = text
  end

  def text
    self.contentTmp.text.to_s
  end

  private
  def set_default_values
    self.contentTmp, self.resourceArray =
        Content.new, Array.new
  end

  def save_content_resource

    self.contentTmp.paragraph_id = self.id
    self.contentTmp.save

    self.resourceArray.each_with_index do |res, index|
      res.paragraph_id = self.id
      res.index = index + 1
      res.save
    end
  end



end
