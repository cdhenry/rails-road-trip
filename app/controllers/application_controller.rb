class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :has_no_values?
  before_action :require_login

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    current_user.id != nil
  end

  def require_login
    if !logged_in?
      flash[:error] = "You must log in to perform this action."
      redirect_to root_path
    end
  end

  def has_no_values?(array)
    array.select{|v| v != "" && v != nil}.empty?
  end

  def set_model
    key = params.keys.last
    model = key.tr('_', ' ').chomp(" id").split.map(&:capitalize).join('')
    @model = eval model + ".find(params[:#{key}])"
  end
end
