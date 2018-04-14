class User < ActiveRecord::Base
  belongs_to :current_trip, class_name: 'RoadTrip', foreign_key: 'current_trip_id'

  has_many :user_road_trips
  has_many :road_trips, through: :user_road_trips

  has_secure_password

  def self.road_warriors
    all.order(miles_driven: :desc).limit(10)
  end
end
