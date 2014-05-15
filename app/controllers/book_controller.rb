class BookController < ApplicationController

  protect_from_forgery except: :store_modify_paragraph

  def get_book_all

    @books = Book.all
    respond_to do |format|

      format.json { render json: @books.to_json, content_type: "application/json" }

    end

  end

  def get_chapter_all

    @chapters = Book.find(params[:book_id]).chapters

    respond_to do |format|

      format.json { render json: @chapters.to_json }

    end

  end

  def get_paragraphs_all

    @paragraphs = Array.new
    modparagraphs = Array.new

    Chapter.find(params[:chapter_id]).modifyparagraphs.each do |modparagraph|

      prev_id = modparagraph.prev_id unless modparagraph.prev_id.nil?
      next_id = modparagraph.next_id unless modparagraph.next_id.nil?

      modparagraphs << { :id => modparagraph.id, :text => modparagraph.content,
                         :prev_id => prev_id, :next_id => next_id }

    end

    Chapter.find(params[:chapter_id]).paragraphs.each do |paragraph|

      flag = false
      modparagraphs.each do |par|
        if par[:next_id] == paragraph.id then
          @paragraphs << { :id => par[:id], :text => par[:text] }
          @paragraphs << {:id=>paragraph.id, :text => paragraph.content.text}
          flag = true
          modparagraphs.delete par
        end

        if par[:prev_id] == paragraph.id then
          @paragraphs << {:id=>paragraph.id, :text => paragraph.content.text}
          @paragraphs << { :id => par[:id], :text => par[:text] }
          flag = true
          modparagraphs.delete par
        end

      end

      unless flag then
        @paragraphs << {:id=>paragraph.id, :text => paragraph.content.text}
      end

    end




    respond_to do |format|

      format.json { render json: @paragraphs.to_json }

    end

  end

  def store_modify_paragraph

    @modifyparagraph = Modifyparagraph.new(:chapter_id => params[:chapter_id],
      :book_id => params[:book_id], :prev_id => params[:prev_id], :next_id => params[:next_id],
      :content => params[:content])

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

end
