class CommentsController < ApplicationController
  
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
end
