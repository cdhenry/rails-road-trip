class RoadTripDestination < ActiveRecord::Base
  belongs_to :destination
  belongs_to :road_trip
  validates_associated :destination
  validates_associated :road_trip
  accepts_nested_attributes_for :road_trip
  accepts_nested_attributes_for :destination

  def new_destination
    destination = Destination.new
    destination.road_trip_destinations.build(road_trip_id: self.road_trip_id)
    destination
  end
end
