class Tag < ActiveRecord::Base
  validates :title, presence: true

  has_many :destination_tags
  has_many :destinations, through: :destination_tags

end
