class DestinationRoadTrip < ActiveRecord::Base
  belongs_to :destination
  belongs_to :road_trip
end
