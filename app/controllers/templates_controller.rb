class TemplatesController < ApplicationController
  def index

  end

  def test

  end

  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end
end
