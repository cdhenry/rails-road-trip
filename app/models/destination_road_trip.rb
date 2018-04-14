class DestinationRoadTrip < ActiveRecord::Base
  validates :destination_id, presence: true
  validates :road_trip_id, presence: true
  validates :destination_id, uniqueness: { scope: :road_trip_id,
    message: "Cannot list the same destination twice" }

  belongs_to :destination
  belongs_to :road_trip

  accepts_nested_attributes_for :destination
end
