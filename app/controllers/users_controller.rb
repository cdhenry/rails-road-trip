class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:new, :create]

  def index
    if current_user.admin
      @users = User.all
    else
      @users = User.road_warriors
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private
    # def set_user
    #   @user = User.find(params[:id])
    # end

    def user_params
      params.require(:user).permit(:name, :email, :password, :current_trip_id, user_road_trips_attributes: [:completed, :road_trip_id])
    end

    def authorize
      if current_user.id != params[:id].to_i && !current_user.admin
        flash[:error] = "You can only edit your own account."
        redirect_to @user
      end
    end
end
