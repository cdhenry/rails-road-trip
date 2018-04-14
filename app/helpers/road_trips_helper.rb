module RoadTripsHelper
  def completed?(road_trip)
    if trip = UserRoadTrip.find_by(road_trip_id: road_trip.id, user_id: current_user.id)
      if trip.status == "Completed"
        return true
      end
    end
  end

  def in_process?(road_trip)
    if trip = UserRoadTrip.find_by(road_trip_id: road_trip.id, user_id: current_user.id)
      if trip.status == "In Process"
        return true
      end
    end
  end
end
