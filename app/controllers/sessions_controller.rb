class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user = user.try(:authenticate, params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Your email or password was incorrect."
      redirect_to signin_path
    end
  end

  def destroy
    session.delete :user_id

    redirect_to '/'
  end
end
