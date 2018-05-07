class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  def author
    User.where(id: self.author_id).select(:id, :name).take || false
  end
end
