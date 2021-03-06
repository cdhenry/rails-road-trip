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
    @length = Tag.all.length
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @tag }
    end
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    if params[:destination_id]
      @tag = Destination.find(params[:destination_id]).tags.build(tag_params)
      if @tag.save
        render json: @tag
      else
        flash[:error] = "Tag was not created."
        render `destinations/#{params[:destination_id]}`
      end
    else
      @tag = Tag.new(tag_params)
      if @tag.save
        redirect_to @tag
      else
        render :new
      end
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
