class BookController < ApplicationController

  def get_book_all

    @books = Book.all
    respond_to do |format|

      format.json { render json: @books}

    end

  end

  def get_chapter_all

    @chapters = Book.find(params[:book_id]).chapters

    respond_to do |format|

      format.json { render json: @chapters }

    end

  end

  def get_paragraphs_all

    @paragraphs = Array.new

    Chapter.find(params[:chapter_id]).paragraphs.each do |chapter|

      @paragraphs << chapter.content.text

    end


    respond_to do |format|

      format.json { render json: @paragraphs }

    end

  end


  def all
    Book.all
  end

  def books
    self.all
  end

  def chapters

    if params[:id].nil? then
      nil
    else
      book = Book.find(params[:id].to_s.to_i)
      book.chapters
    end

  end

end
