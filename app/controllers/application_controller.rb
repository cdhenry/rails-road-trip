class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :require_login
  skip_before_action :require_login, only: [:home]

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    current_user.id != nil
  end

  def require_login
    flash[:error] = "You must log in to perform this action."
    redirect_to root_path unless logged_in?
  end
end
