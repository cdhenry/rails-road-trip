class RoadTripSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :title, :description, :total_miles
end
