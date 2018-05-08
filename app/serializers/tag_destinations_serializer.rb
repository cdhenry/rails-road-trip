class TagDestinationsSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :state, :street_address
end
