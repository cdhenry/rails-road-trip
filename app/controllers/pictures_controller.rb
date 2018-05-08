class PicturesController < ApplicationController

  def show
    @picture = Picture.find(params[:id])
    render json: @picture, status: 200
  end

end
