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
  has_many :destination_road_trips
  has_many :road_trips, through: :destination_road_trips
  has_many :users, through: :road_trips

  accepts_nested_attributes_for :tags

  def city_and_state
    "#{self.city}, #{self.state}"
  end

  def on_this_trip?(road_trip)
    drt = DestinationRoadTrip.where(road_trip_id: road_trip.id).where(destination_id: self.id)
    if !drt.empty?
      drt.first.destination_order
    end
  end

  def tags_attributes=(tag_attributes)
    tag_attributes.values.each do |tag_attribute|
      tag_attribute.each_value do |title|
        if title != ""
          self.tags.build(title: title)
        end
      end
    end
  end
end
