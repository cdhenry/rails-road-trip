class Tag < ActiveRecord::Base
  attr_accessor :tag_1, :tag_2, :tag_3

  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :destination_tags
  has_many :destinations, through: :destination_tags

  def self.popularity_ordered
    joins(:destination_tags).group("destination_tags.tag_id").order("COUNT(destination_tags.tag_id) DESC")
  end

  def times_used
    self.destinations.count
  end

  def last_destination
    if last_association = DestinationTag.where(tag_id: self.id).order(created_at: :desc).limit(1).first
      Destination.find(last_association.destination_id)
    end
  end
end
