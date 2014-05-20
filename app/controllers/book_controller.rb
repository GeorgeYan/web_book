class BookController < ApplicationController

  protect_from_forgery except: :store_modify_paragraph

  def get_book_all

    @books = Book.all
    respond_to do |format|

      format.json { render json: @books.to_json }

    end

  end

  def get_chapter_all

    @chapters = Array.new

    chapterList = Book.find(params[:book_id]).chapters.map{ |ele|
      {:id => ele.id, :title => ele.title, :child => Array.new} if ele.degree == 1
    }

    for chapter in chapterList

      unless chapter.nil? then
        chapter[:child] = find_child(chapter[:id])
        @chapters << chapter
      end


    end

    respond_to do |format|
      format.json { render json: @chapters.to_json }
    end

  end

  def delete_book

    book_id = params[:book_id]

    respond_to do |format|

      if Book.delete book_id then
        format.json { render json: book_id.to_json }
      end

    end

  end

  def get_paragraphs_all

    @paragraphs = Array.new

    Chapter.find(params[:chapter_id]).paragraphs.each do |paragraph|

      tmpParagraph = Hash.new

      tmpParagraph.store(:modify, paragraph.modifyparagraph.content) && tmpParagraph.store(:modify_id, paragraph.modifyparagraph.id) unless paragraph.modifyparagraph.nil?

      tmpParagraph.store(:id, paragraph.id)
      tmpParagraph.store(:text, paragraph.contents.inject(""){|sum, ele| sum + ele.text.to_s})

      @paragraphs << tmpParagraph

    end

    respond_to do |format|

      format.json { render json: @paragraphs.to_json }

    end

  end

  def store_modify_paragraph

    @modifyparagraph = Modifyparagraph.new(:chapter_id => params[:chapter_id],
      :book_id => params[:book_id], :prev_id => 0, :next_id => 0,
      :content => params[:content], :paragraph_id => params[:paragraph_id])

    respond_to do |format|
      if @modifyparagraph.save then
        format.json { render json: "OK" }
      else
        format.json { render json: "NO" }
      end
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

  def find_child id

    Chapter.find(id).child_chapter.map { |ele|
      {:id => ele.id, :title => ele.title, :child => find_child(ele.id)}
    } unless Chapter.find(id).child_chapter.empty?

  end


end
