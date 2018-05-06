module RoadTripDestinationsHelper
  def rtd_destination_finder(rtd)
    Destination.find(rtd.destination_id)
  end

  def rtds_find_or_build(road_trip, destination)
    rtd = RoadTripDestination.where(road_trip_id: road_trip.id).where(destination_id: destination.id).first
    if !rtd.nil?
      rtd
    else
      a = RoadTripDestination.new(road_trip_id: road_trip.id, destination_id: destination.id)
      binding.pry
    end
  end

  def find_destination_order(road_trip:, destination:)
    if rtd = RoadTripDestination.find_by(road_trip_id: road_trip.id, destination_id: destination.id)
      rtd.destination_order
    end
  end

  def find_destination_road_trip(road_trip:, destination:)
    RoadTripDestination.find_by(road_trip_id: road_trip.id, destination_id: destination.id)
  end
end
