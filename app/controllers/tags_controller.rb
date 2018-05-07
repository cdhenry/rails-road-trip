class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    if params[:destination_id]
      @tags = Destination.find(params[:destination_id]).tags.popularity_ordered
    else
      @tags = Tag.popularity_ordered
    end
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end

    def authorize
      if !current_user.admin
        flash[:error] = "Only admin can edit tags at the moment."
        redirect_to @tag
      end
    end
end
