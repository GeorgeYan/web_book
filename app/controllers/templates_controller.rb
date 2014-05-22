class TemplatesController < ApplicationController
  def index

  end

  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end

  def chapter_show
    @chapter_id = params[:chapter_id]
    render :template => 'templates/paragraph.html.erb'
  end

end
