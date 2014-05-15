class Chapter < ActiveRecord::Base

  has_many :paragraphs
  has_many :modifyparagraphs
  belongs_to :book
  has_many :child_chapter, class_name: "Chapter",
                           foreign_key: "parent_id"
  belongs_to :parent, class_name: "Chapter"

  after_initialize :set_default_values
  after_save :save_paragraph
  before_save :set_chapter_values

  attr_accessor :children, :paragraphArray, :prev, :next

  private
  def set_default_values
    self.children, self.paragraphArray = Array.new, Array.new
  end

  def set_chapter_values

    parent = self.parent_id.nil? ? nil : Book.find(self.book_id).chapters.where("index=#{self.parent_id}").last
    self.parent_id = parent.nil? ? 0 : parent.id

  end

  def save_paragraph

    self.paragraphArray.each do |paragraph|
      paragraph.chapter_id, paragraph.book_id, paragraph.is_only_text =
          self.id, self.book_id, paragraph.resourceArray.empty? ? 1 : 0
      paragraph.save
    end

  end


end
