class UserRoadTripsController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    if trip_status == "Reset"
      if find_urt.status == "Completed"
        @user.miles_driven = @user.miles_driven.to_i - RoadTrip.find(params[:user_road_trip][:road_trip_id]).total_miles.to_i
        @user.save
      end
      find_urt.destroy if find_urt
      @user.current_trip_id = nil
      redirect_to road_trip_path(trip_id)
    elsif trip_status == "In Process" && current_user.current_trip_id
      flash[:error] = "You cannot be on two trips at once"
      redirect_to road_trip_path(trip_id)
    elsif urt = find_urt && trip_status == "Completed"
      urt.status = trip_status
      check_completed
      urt.save
      redirect_to road_trip_path(trip_id)
    else
      urt = UserRoadTrip.new(user_road_trip_params)
      check_completed
      urt.save
      @user.current_trip_id = trip_id if trip_status == "In Process"
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

    def find_urt
      UserRoadTrip.find_by(road_trip_id: params[:user_road_trip][:road_trip_id], user_id: params[:user_road_trip][:user_id])
    end

    def check_completed
      if trip_status == "Completed"
        @user.miles_driven = @user.miles_driven.to_i + RoadTrip.find(params[:user_road_trip][:road_trip_id]).total_miles.to_i
        @user.save
        if @user.current_trip_id == trip_id
          @user.current_trip_id = nil
        end
      end
    end

    def set_user
      @user = User.find(params[:user_road_trip][:user_id])
    end
end
