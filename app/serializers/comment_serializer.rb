class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author, :body, :commentable_type, :type_object
end
