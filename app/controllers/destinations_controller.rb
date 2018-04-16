class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only:[:edit, :update, :destroy]

  def index
    if params[:road_trip_id]
      @destinations = RoadTrip.find(params[:road_trip_id]).destinations
    else
      @destinations = Destination.all
    end
  end

  def show
  end

  def new
    @destination = Destination.new
  end

  def edit
    if !current_user.admin
      flash[:error] = "Only admin can edit destinations at the moment."
      redirect_to @destination
    end
  end

  def create
    @destination = Destination.new(destination_params)

    if @destination.save
      redirect_to @destination
    else
      render :new
    end
  end

  def update
    if @destination.update(destination_params)
      redirect_to @destination
    else
      render :edit
    end
  end

  def destroy
    @destination.destroy
    redirect_to destinations_url
  end

  private
    def set_destination
      @destination = Destination.find(params[:id])
    end

    def destination_params
      params.require(:destination).permit(:name, :description, :city, :state, :street_address, tag_ids:[], tags_attributes: [:tag_1, :tag_2, :tag_3])
    end

    def authorize
      if !current_user.admin
        flash[:error] = "Only admin can edit tags at the moment."
        redirect_to @destination
      end
    end
end
