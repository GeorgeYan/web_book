class Book < ActiveRecord::Base

  has_many :chapters
  has_many :paragraphs

  after_initialize :set_default_values
  after_save :save_chapter

  attr_accessor :chapterArray, :paragraphArray

  def analyze_chapter

    chapterParent = Array.new

    @chapterArray.each_with_index do |chapter, index|

      unless chapterParent.empty? then
        if chapter.degree > @chapterArray[chapterParent.last].degree then
          @chapterArray[chapterParent.last].children << index
          chapter.parent_id = chapterParent.last
          chapterParent << index
        elsif chapter.degree == @chapterArray[chapterParent.last].degree then
          chapter.prev = chapterParent.last
          @chapterArray[chapterParent.last].next = index
          chapter.parent_id = @chapterArray[chapterParent.last].parent_id
          chapter.parent_id.nil? ?  nil : @chapterArray[chapter.parent_id].children << index
          chapterParent.pop
          chapterParent << index
        else
          while !chapterParent.empty? do
            popdata = chapterParent.pop
            if @chapterArray[popdata].degree == chapter.degree then
              @chapterArray[popdata].next = index
              chapter.prev = popdata
              chapter.parent_id = @chapterArray[popdata].parent_id
              chapter.parent_id.nil? ?  nil : @chapterArray[chapter.parent_id].children << index
              chapterParent << index
              break
            end
          end
        end
      else
        chapterParent << index
      end

    end

  end

  private
  def set_default_values
    self.chapterArray, self.paragraphArray =
        Array.new, Array.new
  end

  def save_chapter

    self.chapterArray.each do |chapter|
      chapter.book_id = self.id
      chapter.save
    end

  end


end
