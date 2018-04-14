class DestinationTag < ActiveRecord::Base
  belongs_to :destination
  belongs_to :tag
end
