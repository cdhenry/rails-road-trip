class Destination < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :street_address, uniqueness: true

  has_many :destination_tags
  has_many :tags, through: :destination_tags
  has_many :destination_road_trips
  has_many :road_trips, through: :destination_road_trips
  has_many :users, through: :road_trips

  accepts_nested_attributes_for :tags

end
