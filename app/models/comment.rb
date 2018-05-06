class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  def author
    User.find(self.author_id) || false
  end
end
