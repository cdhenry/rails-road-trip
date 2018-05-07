class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  def self.comments_made(user)
    where(author_id: user.id)
  end

  def author
    User.where(id: self.author_id).select(:id, :name).take || false
  end

  def type_object
    eval(self.commentable_type + ".where(id: " + self.commentable_id.to_s + ").select(:id, :name, :title).take")
  end
end
