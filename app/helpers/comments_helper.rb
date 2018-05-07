module CommentsHelper
  def get_user_name(id)
    User.find(id).name
  end

  def model_comments_path(model)
    model.class.name.split(/(?=[A-Z])/).join('_').downcase + "_comments_path"
  end
end
