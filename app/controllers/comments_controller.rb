class CommentsController < ApplicationController

  def index
    @comments = comment_index_params
    render json: @comments, status: 200
  end

  private
    def comment_index_params()
      key = params.keys[2]
      model = key.tr('_', ' ').chomp(" id").split.map(&:capitalize).join('')
      eval model + ".find(params[:#{key}]).comments"
    end
end
