class DestinationRoadTrip < ActiveRecord::Base
  belongs_to :destination
  belongs_to :road_trip
  validates_associated :destination
  validates_associated :road_trip
  accepts_nested_attributes_for :road_trip
  accepts_nested_attributes_for :destination
end
