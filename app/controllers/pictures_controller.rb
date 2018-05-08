class PicturesController < ApplicationController
  before_action :set_model

  def index
    @pictures = @model.pictures
    render json: @pictures, status: 200
  end

  def show
    @picture = Picture.find(params[:id])
    render json: @picture, status: 200
  end

  private
    def set_model
      key = params.keys.last
      model = key.tr('_', ' ').chomp(" id").split.map(&:capitalize).join('')
      @model = eval model + ".find(params[:#{key}])"
    end
end
