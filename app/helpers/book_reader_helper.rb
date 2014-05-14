
module BookReaderHelper

  IMAGE = "image"
  TEXT  = "text"

  class Reader

    attr_reader :book

    def initialize file_path, options = {}

      if file_path.nil? || !File.exist?(file_path) then
        raise StandardError, "The input #{file_path} is WRONG."
        return
      end

      @book = Book.new

      analyze file_path

      @book.name.empty? ? @book.name = File.basename(file_path) : ""

      @book.analyze_chapter

    end

    private

    def analyze file_path

      parse file_path
      get_book_content

    end

    def parse file_path

      @bookRootObj = Nokogiri::XML.parse(File.read(file_path))

    end

    def get_book_name

      @book.name = @bookRootObj.xpath("//book").attr("name").to_s

    end

    # get information as a book form xml file
    def get_book_content

      get_book_name

      @bookRootObj.xpath("//paras").children.each do |child|

        if child.name == "p" then
          get_p_info child
        elsif child.name == "mp" then
          get_mp_info child
        else
          #raise StandardError, "Can't get this tag <#{child.name}>."
        end
      end
    end

    # get information form "<p>" tag
    # get chapter information form this tag.
    # <p>两人剑法迅捷，全力相搏。&#x0A;</p>
    #
    # <p font="h1" para="h1">第一章 青衫磊落险峰行&#x0A;</p>
    def get_p_info p

      if p.attr("font").to_s =~ /(h|H)\d+/ then
        get_p_chapter p
      else
        get_p_text p
      end

    end

    # get information form "<mp>" tag
    # get chapter information from this tag.
    #
    # <mp para="h1">
    #   <text font="h1">第二章 玉壁月华明</text>
    #   <text>&#x0A;</text>
    # </mp>
    #
    # <mp>
    #   <text>折腾了这久，月亮已渐，</text>
    #   <text font="h1">&#x0A;</text>
    # </mp>
    #
    # <mp para="border">
    #   <text>青光</text>
    #   <annotation text="青光 " font="" />
    #   <text>闪动，一柄青钢剑倏地刺出，指向在年汉子左</text>
    #   <text font="h1">&#x0A;</text>
    # </mp>
    #
    # <mp para="image">
    #   <img src="res/zhongguo.png" />
    #   <text>&#x0A;</text>
    # </mp>
    def get_mp_info mp

      is_chapter = false

      mp.children.each do |tmp|
        if tmp.name == "text" then

          if !tmp.attr("font").nil? && tmp.attr("font").to_s =~ /(h|H)\d+/ then
            is_chapter = true
          end

        end
      end

      is_chapter ? get_mp_chapter(mp) : get_mp_paragraph(mp)

    end



    def get_p_text p

      set_paragraph_info do |tmp|
        tmp.text = p.text
      end

    end

    def get_p_chapter p

      set_chapter_info do |tmp|
        tmp.degree = /(h|H)(?<degree>\d+)/ =~ p.attr("font") ? degree.to_i : 0
        tmp.title = p.text
      end

    end

    def get_mp_paragraph mp

      set_paragraph_info do |tmp|
        mp.children.each do |child_tag|
          if child_tag.name == "text" then
            tmp.text += child_tag.text.to_s.strip
          end

          if child_tag.name == "img" then
            tmp.resourceArray << get_mp_child_image_info(child_tag)
            tmp.text += "<" + BookReaderHelper::IMAGE + "_#{tmp.resourceArray.length}>"
          end
        end
      end

    end


    def get_mp_chapter mp

      set_chapter_info do |tmp|
        flag = true
        tmp.title = ""
        mp.children.each do |child_tag|
          if flag && !child_tag.attr("font").nil? && /(h|H)(?<degree>\d+)/ =~ child_tag.attr("font") then
            tmp.degree = degree.to_i
            flag = false
          end
          tmp.title += (child_tag.text.nil? ? "" : child_tag.text.to_s)
        end
      end

    end

    # get image information from this tag.
    # <mp para="image">
    #   <img src="res/zhongguo.png" />
    #   <text>&#x0A;</text>
    # </mp>
    def get_mp_child_image_info mp_child

      resource = Resource.new
      resource.location, resource.rtype =
          mp_child.attr("src").to_s, BookReaderHelper::IMAGE
      resource

    end

    def set_chapter_info

      tmpChapter = Chapter.new
      yield tmpChapter
      tmpChapter.index = @book.chapterArray.length
      @book.chapterArray << tmpChapter

    end

    def set_paragraph_info

      tmpParagraph = Paragraph.new
      yield tmpParagraph
      tmpParagraph.parent = @book.chapterArray.empty? ? nil : (@book.chapterArray.length-1)
      tmpParagraph.index = @book.paragraphArray.length
      @book.chapterArray.empty? ? nil : @book.chapterArray.last.paragraphArray << tmpParagraph
      @book.paragraphArray << tmpParagraph

    end

  end
end