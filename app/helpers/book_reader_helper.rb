
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
      get_book_name
      get_book_style
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

      get_tag_child_info("paras") do |child|
        get_tag_info("p", child) || get_tag_info("mp", child)
      end

    end

    def get_book_style

      get_tag_child_info("style") do |child|
        get_tag_info("font", child)
      end

    end

    def get_tag_child_info tag_name

      @bookRootObj.xpath("//#{tag_name}").children.each do |child|
        yield child
      end

    end

    def get_tag_info tag_name, tag

      send("get_#{tag_name}_info", tag)||true if tag.name == tag_name

    end


    # get information form tag:
    # <font name="ht" family="黑体" size="20" bold="false" italic="false" underline="false" color="0;0;0" syscolor="1" />

    def get_font_info font

      set_font_info do |bookFont|
        bookFont.name = font.attr("name")
        bookFont.family = font.attr("family")
        bookFont.size = font.attr("size").to_i
        bookFont.bold = font.attr("bold")=="true" ? true : false
        bookFont.italic = font.attr("italic")=="true" ? true : false
        bookFont.underline = font.attr("false")=="true" ? true : false
        if /(?<r_data>\d+);(?<g_data>\d+);(?<b_data>\d+)/ =~ font.attr("color") then
          bookFont.colorR = r_data.to_i
          bookFont.colorG = g_data.to_i
          bookFont.colorB = b_data.to_i
        end
        bookFont.syscolor = font.attr("syscolor").to_i
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

      set_paragraph_info do |paragraph|

        mp.children.each do |mp_child|

          # 特殊处理含有章节的内容
          get_mp_child_chapter(mp_child) ||
              get_mp_child_text(mp_child, paragraph) ||
              get_mp_child_image(mp_child, paragraph)

        end

      end

    end


    def get_mp_child_text mp_child, paragraph

      paragraph.contentArray << set_content_font_info do |content|

        content.text = mp_child.text.to_s.strip
        content.book_font_name = mp_child.attr("font").nil? ? "" : mp_child.attr("font").to_s
        content.index = paragraph.resourceArray.length +
            paragraph.contentArray.length

      end || true if mp_child.name == "text"

    end

    def get_mp_child_image mp_child, paragraph

      paragraph.resourceArray << set_image_info(mp_child) do |image|

        image.index = paragraph.resourceArray.length +
            paragraph.contentArray.length

      end || true if mp_child.name=="img"

    end

    def get_mp_child_chapter mp_child

      set_chapter_info do |chapter|

        chapter.title = mp_child.text.to_s
        chapter.font_name = mp_child.attr("font").to_s
        chapter.degree = /(h|H)(?<degree>\d+)/ =~ p.attr("font") ? degree.to_i : 0

      end || true if mp_child.name=="text" && mp_child.attr("font") =~ /(h|H)\d+/

    end


=begin
    def get_mp_infox mp

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
=end


    def get_p_text p

      set_paragraph_info do |tmp|

        tmp.contentArray << set_content_font_info do |content|

          content.text = p.text
          content.book_font_name = p.attr("font").nil? ? "" : p.attr("font").to_s

        end

      end

    end

    def get_p_chapter p

      set_chapter_info do |tmp|
        tmp.degree = /(h|H)(?<degree>\d+)/ =~ p.attr("font") ? degree.to_i : 0
        tmp.font_name = p.attr("font").nil? ? "" : p.attr("font").to_s
        tmp.title = p.text
      end

    end

=begin
    def get_mp_paragraph mp

      set_paragraph_info do |tmp|
        mp.children.each do |child_tag|
          if child_tag.name == "text" then
            tmp.contentArray << set_content_font_info do |content|

              content.text = child_tag.text.to_s.strip
              content.book_font_name = child_tag.attr("font").nil? ? "" : child_tag.attr("font").to_s
              content.index = tmp.resourceArray.length + tmp.contentArray.length

            end
          end

          if child_tag.name == "img" then

            tmp.resourceArray << get_mp_child_image_info(child_tag) do |content|
              content.index = tmp.resourceArray.length + tmp.contentArray.length
            end

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
            tmp.font_name = child_tag.attr("font").to_s
            tmp.degree = degree.to_i
            flag = false
          end
          tmp.title += (child_tag.text.nil? ? "" : child_tag.text.to_s)
        end
      end

    end
=end
    # get image information from this tag.
    # <mp para="image">
    #   <img src="res/zhongguo.png" />
    #   <text>&#x0A;</text>
    # </mp>
    def set_image_info mp_child

      resource = Resource.new
      resource.location, resource.rtype =
          mp_child.attr("src").to_s, BookReaderHelper::IMAGE
      yield resource
      resource

    end

    def set_chapter_info

      tmpChapter = Chapter.new
      yield tmpChapter
      tmpChapter.index = @book.chapterArray.length
      @book.chapterArray << tmpChapter

    end

    def set_content_font_info

      tmpContent = Content.new
      yield tmpContent
      tmpContent

    end

    def set_paragraph_info

      tmpParagraph = Paragraph.new
      yield tmpParagraph
      tmpParagraph.parent = @book.chapterArray.empty? ? nil : (@book.chapterArray.length-1)
      tmpParagraph.index = @book.paragraphArray.length
      @book.chapterArray.empty? ? nil : @book.chapterArray.last.paragraphArray << tmpParagraph
      @book.paragraphArray << tmpParagraph

    end

    def set_font_info

      tmpFont = BookFont.new
      yield tmpFont
      @book.fontArray << tmpFont

    end

  end
end