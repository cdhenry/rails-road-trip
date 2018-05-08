class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :destinations
  has_many :destinations, serializer: TagDestinationsSerializer
end
