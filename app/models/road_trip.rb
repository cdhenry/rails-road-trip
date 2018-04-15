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
end
