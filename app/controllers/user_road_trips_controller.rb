class UserRoadTripsController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    case trip_status
    when "Reset"
      reset_trip_attributes
      redirect_to road_trip_path(trip_id)
    when "Completed"
      trip_status_complete
      redirect_to road_trip_path(trip_id)
    when "In Process"
      if current_user.current_trip_id
        flash[:error] = "You cannot be on two trips at once"
        redirect_to road_trip_path(trip_id)
      else
        trip_status_in_process
        redirect_to road_trip_path(trip_id)
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:user_road_trip][:user_id])
    end
    
    def user_road_trip_params
      params.require(:user_road_trip).permit(:status, :user_id, :road_trip_id)
    end

    def trip_id
      params[:user_road_trip][:road_trip_id].to_i
    end

    def trip_status
      params[:user_road_trip][:status]
    end

    def find_urt
      UserRoadTrip.find_by(road_trip_id: params[:user_road_trip][:road_trip_id], user_id: params[:user_road_trip][:user_id])
    end
    
    def trip_status_complete
      if urt = find_urt
        urt.status = trip_status
      else
        urt = UserRoadTrip.new(user_road_trip_params)
      end

      update_miles_driven("up")
      reset_current_trip
      urt.save
    end

    def trip_status_in_process
      urt = UserRoadTrip.create(user_road_trip_params)
      @user.current_trip_id = trip_id 
      @user.save
    end

    def update_miles_driven(string)
      if string == "down"
        @user.miles_driven = @user.miles_driven.to_i - RoadTrip.find(params[:user_road_trip][:road_trip_id]).total_miles.to_i
      elsif string == "up"
        @user.miles_driven = @user.miles_driven.to_i + RoadTrip.find(params[:user_road_trip][:road_trip_id]).total_miles.to_i
      end
      @user.save
    end

    def reset_trip_attributes
      if find_urt 
        update_miles_driven("down") if find_urt.status == "Completed"
        find_urt.destroy
      end
      reset_current_trip
    end

    def reset_current_trip
      if @user.current_trip_id.to_i == trip_id
        @user.current_trip_id = nil 
        @user.save
      end
    end
end
