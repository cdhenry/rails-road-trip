module CommentsHelper
  def get_user_name(id)
    User.find(id).name
  end
end
