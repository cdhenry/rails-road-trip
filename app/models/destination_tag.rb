class DestinationTag < ActiveRecord::Base
  validates :destination_id, presence: true
  validates :tag_id, presence: true
  validates :destination_id, uniqueness: { scope: :tag_id,
    message: "A tag can be associated with a destination only once."}

  belongs_to :destination
  belongs_to :tag
end
