class PictureSerializer < ActiveModel::Serializer
  attributes :id, :url, :imageable_id, :imageable_type
end
