class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.book_id = params[:book_id]
    @comment.save
    redirect_to @comment.book, notice: "You have creatad comment successfully."
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.book, notice: "You have deleted comment successfully."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
