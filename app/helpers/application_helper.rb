module ApplicationHelper
  def urts_find_or_build(road_trip, user)
    urt = UserRoadTrip.where(road_trip_id: road_trip.id).where(user_id: user.id).first
    if !urt.nil?
     urt
    else
     UserRoadTrip.new(road_trip_id: road_trip.id, user_id: user.id)
    end
  end
end
