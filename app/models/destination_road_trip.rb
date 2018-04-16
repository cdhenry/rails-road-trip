class DestinationRoadTrip < ActiveRecord::Base
  validates :destination_id, presence: true
  validates :road_trip_id, presence: true
  validates :road_trip_id, uniqueness: { scope: :destination_id,
    message: "A destination can be associated with a trip only once."}

  belongs_to :destination
  belongs_to :road_trip
end
