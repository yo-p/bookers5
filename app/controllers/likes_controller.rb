class LikesController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @like = current_user.likes.create(book_id: params[:book_id])
  end

  def destroy
    @book = Book.find(params[:book_id])
    @like = Like.find_by(book_id: params[:book_id], user_id: current_user.id)
    @like.destroy
  end
end
