class CommentsController < ApplicationController
  include CommentsHelper
  before_action :set_model

  def index
    if params.keys.last == "user_id"
      @comments = Comment.comments_made(@model)
    else
      @comments = @model.comments
    end
      render json: @comments, status: 200
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: 200
  end

  def create
    @comment = @model.comments.build(comments_params)
    if @comment.save
      render 'comments/show', layout: false
    else
      flash[:error] = "Comment was not created."
      render `#{@model.class.name.pluralize}/show`
    end
  end

  private

    def comments_params
      params.require(:comment).permit(:body, :author_id)
    end
end
