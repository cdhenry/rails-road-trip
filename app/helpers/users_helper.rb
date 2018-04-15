module UsersHelper
  def admin_controls(model)
    model.class.name.split(/(?=[A-Z])/).join('_').downcase
  end
end
