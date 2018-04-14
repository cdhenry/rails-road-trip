class RegistrationsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
    if current_user.update
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
  end
end
