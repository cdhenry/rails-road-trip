class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.popularity_ordered
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
      params.require(:tag).permit(:title)
    end
end
