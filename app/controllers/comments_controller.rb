class CommentsController < ApplicationController
  before_action :set_model

  def index
    @comments = @model.comments
    render json: @comments, status: 200
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: 200
  end

  def create
    @comment = @model.comments.build(comments_params)
    if @comment.save
      redirect_to @comment
    end
  end

  private
    def set_model
      key = params.keys.last
      model = key.tr('_', ' ').chomp(" id").split.map(&:capitalize).join('')
      @model = eval model + ".find(params[:#{key}])"
    end

    def comments_params 
      params.require(:comment).permit(:body, :author_id)
    end
end
