class RoadTrip < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :total_miles, presence: true
  validates :author_id, presence: true

  has_many :user_road_trips
  has_many :users, through: :user_road_trips
  has_many :destination_road_trips
  has_many :destinations, through: :destination_road_trips
  has_many :tags, through: :destinations

  accepts_nested_attributes_for :destinations
  accepts_nested_attributes_for :destination_road_trips
  accepts_nested_attributes_for :tags

  def author
    User.find(self.author_id)
  end

  def destinations_attributes=(destination_attributes)
    destination_attributes.values.each do |destination_attribute|
      stop_order = destination_attribute["stop_order"]
      destination_attribute.delete("stop_order")
      destination = Destination.find_or_initialize_by(destination_attribute)
      if destination.save
        self.destination_road_trips.create(destination_id: destination.id, destination_order: stop_order)
      end
    end
  end

  def destination_road_trips_attributes=(destination_road_trips_attributes)
    destination_road_trips_attributes.values.each do |destination_road_trip_attribute|
      if drt = self.destination_road_trips.find_by(destination_id: destination_road_trip_attribute["destination_id"])
        drt.destination_order = destination_road_trip_attribute["destination_order"]
        drt.save
      end
    end
  end
end
