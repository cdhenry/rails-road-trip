class PicturesController < ApplicationController
  before_action :set_model, only: [:index]

  def index
    @pictures = @model.pictures
    render json: @pictures, status: 200
  end

  def show
    @picture = Picture.find(params[:id])
    render json: @picture, status: 200
  end
end
