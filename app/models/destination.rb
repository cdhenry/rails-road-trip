class Destination < ActiveRecord::Base
  attr_accessor :stop_order, :tags_attributes

  validates :name, presence: true
  validates :description, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :street_address, uniqueness: true
  validates :author_id, presence: true

  has_many :destination_tags, dependent: :delete_all
  has_many :tags, through: :destination_tags
  has_many :road_trip_destinations, dependent: :delete_all
  has_many :road_trips, through: :road_trip_destinations
  has_many :users, through: :road_trips
  has_many :pictures, as: :imageable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :tags

  def city_and_state
    "#{self.city}, #{self.state}"
  end

  def on_this_trip?(road_trip)
    rtd = RoadTripDestination.where(road_trip_id: road_trip.id).where(destination_id: self.id)
    if !rtd.empty?
      rtd.first.destination_order
    end
  end

  def tags_attributes=(tag_attributes)
    tag_attributes.values.each do |tag_attribute|
      tag_attribute.each_value do |name|
        if name != ""
          self.tags.build(name: title)
        end
      end
    end
  end
end
