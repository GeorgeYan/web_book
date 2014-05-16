class MidifyParagraphController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  def index
  end

  def create
    modify = Modifyparagraph.new
    modify.paragraph_id = params[:paragraphId]
    modify.content = params[:content]

    if modify.valid?
      modify.save!
    else
      render "public/422", :status => 422
      return
    end

    respond_with(modify) do |format|
      format.json { render :json => modify.as_json }
    end
  end

  def destroy
    delete_modify = Modifyparagraph.delete(params[:id])

    respond_with(delete_modify) do |format|
      format.json { render :json => delete_modify.as_json}
    end
  end

  def update
    modify = Modifyparagraph.find(params[:id])
    modify.content = params[:content]

    if modify.valid?
      modify.save
    else
      render "public/422", status => 422
      return
    end

    respond_with(modify) do |format|
      format.json { render :json => modify.as_json }
    end
  end
end
