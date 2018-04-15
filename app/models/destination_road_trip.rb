class DestinationRoadTrip < ActiveRecord::Base
  validates :destination_id, presence: true
  validates :road_trip_id, presence: true

  belongs_to :destination
  belongs_to :road_trip
end
