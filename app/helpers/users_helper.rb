module UsersHelper
  def edit_path(model)
    "edit_" + model.class.name.split(/(?=[A-Z])/).join('_').downcase + "_path"
  end
end
