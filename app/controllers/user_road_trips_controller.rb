class UserRoadTripsController < ApplicationController
  def create
    if trip = UserRoadTrip.find_by(road_trip_id: params[:user_road_trip][:road_trip_id], user_id: params[:user_road_trip][:user_id])
      trip.status = params[:user_road_trip][:status]
      trip.save
      redirect_to road_trip_path(params[:user_road_trip][:road_trip_id])
    else
      trip = UserRoadTrip.new(user_road_trip_params)
      if trip.save
        redirect_to road_trip_path(params[:user_road_trip][:road_trip_id])
      else
        redirect_to road_trip_path(params[:user_road_trip][:road_trip_id])
      end
    end
  end

  private
    def user_road_trip_params
      params.require(:user_road_trip).permit(:status, :user_id, :road_trip_id)
    end
end
