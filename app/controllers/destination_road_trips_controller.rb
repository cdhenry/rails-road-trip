class DestinationRoadTripsController < ApplicationController
  before_action :set_destination_road_trip, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    if params[:user_id]
      @destination_road_trips = User.find(params[:user_id]).destination_road_trips
    else
      @destination_road_trips = DestinationRoadTrip.all
    end
  end

  def show
  end

  def new
    @destination_road_trip = DestinationRoadTrip.new
    @destination_road_trip.road_trip = RoadTrip.new
    @destination_road_trip.destination = Destination.new
  end

  def edit
  end

  def create
    @destination_road_trip = DestinationRoadTrip.new(destination_road_trip_params)
    if has_no_values?(new_destination_params)
      if @destination_road_trip.road_trip.save
        binding.pry
        redirect_to @destination_road_trip.road_trip
      else
        render :new
      end
    else
      @destination_road_trip.destination_order = stop_order_param
      if @destination_road_trip.save
        @destination_road_trip.road_trip.update(road_trip_params["road_trip_attributes"])
        redirect_to @destination_road_trip.road_trip
      else
        render :new
      end
    end
  end

  def update
    if @destination_road_trip.update(destination_road_trip_params)
      @destination_road_trip.road_trip.update(road_trip_params["road_trip_attributes"])
      redirect_to @destination_road_trip.road_trip
    else
      render :edit
    end
  end

  def destroy
    @destination_road_trip.destroy
    redirect_to road_trips_url
  end

  private
    def set_destination_road_trip
      @destination_road_trip = DestinationRoadTrip.find(params[:id])
    end

    def destination_road_trip_params
      params.require(:destination_road_trip).permit(
        :road_trip_id, :destination_id,
        road_trip_attributes: [:title, :description, :total_miles, :author_id, destination_ids: []],
        destination_attributes: [:name, :description, :city, :state, :street_address, :stop_order, tag_ids: [],
          tags_attributes: [:tag_1, :tag_2, :tag_3]]
        )
    end

    def stop_order_param
      params[:destination_road_trip][:destination_attributes][:stop_order]
    end

    def new_destination_params
      params[:destination_road_trip][:destination_attributes].values[0..5]
    end

    def road_trip_params
      params.require(:destination_road_trip).permit(
        road_trip_attributes: [destination_road_trips_attributes: [:destination_id, :destination_order]]
      )
    end

    def destinations_params
      params.require(:destination_road_trip).permit(
        destination_attributes: [:name, :description, :city, :state, :street_address, :stop_order, tag_ids: [],
          tags_attributes: [:tag_1, :tag_2, :tag_3]]
      )
    end

    def authorize
      if current_user.id != @destination_road_trip.road_trip.author_id && !current_user.admin
        flash[:error] = "You can only edit trips you have created."
        redirect_to @destination_road_trip
      end
    end
end
