class AnnotationController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    annotation = Annotation.new
    annotation.paragraph_id = params[:paragraphId]
    annotation.color = params[:color]
    annotation.content = params[:content]
    annotation.start = params[:start]
    annotation.end = params[:end]

    if annotation.valid?
      annotation.save!
    else
      render "public/422", :status => 422
      return
    end

    respond_with(annotation) do |format|
      format.json { render :json => annotation.as_json }
    end
  end

  def destroy
    #annotation = Annotation.where(start: params[:start], end: params[:end]).having(paragraph_id: params[:paragraphId])

    annotation = Annotation.first
    annotation.destroy
    respond_with(annotation) do |format|
      format.json { render :json => annotation.as_json}
    end
  end

end

