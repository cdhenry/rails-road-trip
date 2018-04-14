class SessionsController < ApplicationController
  def new
  end

  def edit
  end

  def create
    user = User.find_by(email: params[:email])
    if user = user.try(:authenticate, params[:email])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to signin_path
    end
  end

  def update
    if current_user.update
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    session.delete :user_id

    redirect_to '/'
  end
end
