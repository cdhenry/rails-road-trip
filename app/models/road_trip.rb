class RoadTrip < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :total_miles, presence: true
  validates :author_id, presence: true
  validates_associated :destinations

  has_many :user_road_trips, dependent: :delete_all
  has_many :users, through: :user_road_trips
  has_many :road_trip_destinations, dependent: :delete_all
  has_many :destinations, through: :road_trip_destinations
  has_many :tags, through: :destinations
  has_many :pictures, as: :imageable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :destinations
  accepts_nested_attributes_for :road_trip_destinations
  accepts_nested_attributes_for :tags

  def author
    User.find(self.author_id) || false
  end

  def set_tags(tags, destination)
    tags.each_value do |name|
      if name != ""
        destination.tags.build(name: name)
      end
    end
  end

  def destinations_attributes=(destination_attributes)
    destination_attributes.values.each do |destination_attribute|
      stop_order = destination_attribute["stop_order"]
      destination_attribute.delete("stop_order")
      tags = destination_attribute["tags_attributes"].first[1]
      destination_attribute.delete("tags_attributes")

      destination = Destination.find_or_initialize_by(destination_attribute)
      set_tags(tags, destination)

      if destination.save
        self.road_trip_destinations.create(destination_id: destination.id, destination_order: stop_order)
      end
    end
  end

  def road_trip_destinations_attributes=(road_trip_destinations_attributes)
    road_trip_destinations_attributes.values.each do |road_trip_destination_attribute|
      if rtd = self.road_trip_destinations.find_by(destination_id: road_trip_destination_attribute["destination_id"])
        rtd.destination_order = road_trip_destination_attribute["destination_order"]
        rtd.save
      else
        self.road_trip_destinations.build(destination_id: road_trip_destination_attribute["destination_id"],
          destination_order: road_trip_destination_attribute["destination_order"])
      end
    end
  end
end
