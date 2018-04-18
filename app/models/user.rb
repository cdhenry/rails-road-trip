class User < ActiveRecord::Base
  scope :road_warriors, -> {all.order(miles_driven: :desc)}

  belongs_to :current_trip, class_name: 'RoadTrip', foreign_key: 'current_trip_id'

  has_many :user_road_trips, dependent: :delete_all
  has_many :road_trips, through: :user_road_trips

  accepts_nested_attributes_for :user_road_trips

  has_secure_password

  def trips_created
    RoadTrip.where(author_id: self.id)
  end

  def destinations_created
    Destination.where(author_id: self.id)
  end

  def user_road_trips_attributes=(user_road_trip_attributes)
    user_road_trip_attributes.values.each do |user_road_trip_attribute|
      user_road_trip = UserRoadTrip.find_or_initialize_by(road_trip_id: user_road_trip_attribute["road_trip_id"], user_id: self.id)
      user_road_trip.completed = user_road_trip_attribute["completed"]
      user_road_trip.save
    end
  end
end
