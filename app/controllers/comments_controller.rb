class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.book_id = params[:book_id]
    @comment.save
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_path
    end
  end
end
