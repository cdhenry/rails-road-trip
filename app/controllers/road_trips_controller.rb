class RoadTripsController < ApplicationController
  before_action :set_road_trip, only: [:show, :edit, :update, :destroy]
  before_action :set_destinations, only: [:new, :edit, :update, :create]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    if params[:user_id]
      @road_trips = User.find(params[:user_id]).road_trips
    else
      @road_trips = RoadTrip.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @road_trips }
    end
  end

  def show
  end

  def new
    @road_trip = RoadTrip.new
  end

  def edit
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        redirect_to users_path, alert: "User not found."
      else
        @road_trip = RoadTrip.find_by(id: params[:id], author_id: params[:user_id])
        redirect_to user_created_trips_path(@user), alert: "No trips found." if @road_trip.nil?
      end
    else
      @road_trip = RoadTrip.find(params[:id])
    end
  end

  def create
    @road_trip = RoadTrip.new(road_trip_params)
    if @road_trip.save
      if check_destination
        @road_trip.update(destination_params)
        redirect_to @road_trip
      else
        flash[:error] = "Your new destination must have a name, description, city, state, and street address."
        render :new
      end
    else
      render :new
    end
  end

  def update
    if @road_trip.update(road_trip_params)
      @road_trip.update(destination_params)
      redirect_to @road_trip
    else
      render :edit
    end
  end

  def destroy
    @road_trip.destroy
    redirect_to road_trips_url
  end

  private
    def set_road_trip
      @road_trip = RoadTrip.find(params[:id])
    end

    def set_destinations
      @destinations = Destination.all
    end

    def road_trip_params
      params.require(:road_trip).permit(
        :title, :description, :total_miles, :author_id,
        )
    end

    def destination_params
      cleanse_rtd_attributes
      params.require(:road_trip).permit(
        destinations_attributes: [:name, :description, :city, :state, :street_address, :author_id, :stop_order,
          tags_attributes: [:tag_1, :tag_2, :tag_3]],
        road_trip_destinations_attributes: [:destination_id, :destination_order]
      ) # you also capture destination_ids [], but are only using them in the cleanse function
    end

    def authorize
      if current_user.id != @road_trip.author_id && !current_user.admin
        flash[:error] = "You can only edit trips you have created."
        redirect_to @road_trip
      end
    end

    def check_destination
      !(params[:road_trip][:destinations_attributes]["0"].values[0..5].include?("") && params[:road_trip][:destinations_attributes]["0"].values[0..5].find{|e| /\S/ =~ e})
    end

    def cleanse_rtd_attributes
      if params[:road_trip][:destination_ids]
        params[:road_trip][:road_trip_destinations_attributes].values.each_with_index do |rtd, i|
          if !params[:road_trip][:destination_ids].include?(rtd["destination_id"])
            params[:road_trip][:road_trip_destinations_attributes].delete("#{i}")
          end
        end
      else
        params[:road_trip][:road_trip_destinations_attributes].values.each_with_index {|rtd, i|
          params[:road_trip][:road_trip_destinations_attributes].delete("#{i}")
        }
      end
    end
end
