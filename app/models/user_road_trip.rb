class UserRoadTrip < ActiveRecord::Base
  belongs_to :user
  belongs_to :road_trip
end
