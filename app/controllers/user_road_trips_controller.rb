class UserRoadTripsController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    if trip_status == "Reset"
      find_trip.destroy if find_trip
      @user.current_trip_id = nil
      @user.save
      redirect_to road_trip_path(trip_id)
    elsif trip_status == "In Process" && current_user.current_trip_id
      flash[:error] = "You cannot be on two trips at once"
      redirect_to road_trip_path(trip_id)
    elsif trip = find_trip
      trip.status = trip_status
      mark_completed
      trip.save
      redirect_to road_trip_path(trip_id)
    else
      trip = UserRoadTrip.new(user_road_trip_params)
      trip.save
      @user.current_trip_id = trip_id
      @user.save
      redirect_to road_trip_path(trip_id)
    end
  end

  private
    def user_road_trip_params
      params.require(:user_road_trip).permit(:status, :user_id, :road_trip_id)
    end

    def trip_id
      params[:user_road_trip][:road_trip_id]
    end

    def trip_status
      params[:user_road_trip][:status]
    end

    def find_trip
      UserRoadTrip.find_by(road_trip_id: params[:user_road_trip][:road_trip_id], user_id: params[:user_road_trip][:user_id])
    end

    def mark_completed
      if current_user.current_trip_id == trip_id && trip_status == "Completed"
        current_user.current_trip_id = nil
      end
    end

    def set_user
      @user = User.find(params[:user_road_trip][:user_id])
    end
end
