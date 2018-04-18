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
    @destination = Destination.new(author_id: params[:author_id])
  end

  def edit
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        redirect_to users_path, alert: "User not found."
      else
        @destination = Destination.find_by(id: params[:id], author_id: params[:user_id])
        redirect_to user_created_trips_path(@user), alert: "No destinations found." if @destination.nil?
      end
    else
      @destination = Destination.find(params[:id])
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
      params.require(:destination).permit(:name, :description, :city, :state, :street_address, :author_id, tag_ids:[], tags_attributes: [:tag_1, :tag_2, :tag_3])
    end

    def authorize
      if @destination.author_id != current_user.id && !current_user.admin
        flash[:error] = "You can only edit destinations you've created."
        redirect_to @destination
      end
    end
end
