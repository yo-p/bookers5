class LikesController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @like = current_user.likes.create(book_id: params[:book_id])

    # @book = Book.find(params[:book_id])
    # @like = current_user.likes.create(book_id: params[:book_id])
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @like = Like.find_by(book_id: params[:book_id], user_id: current_user.id)
    @like.destroy

    # @book = Book.find(params[:book_id])
    # @like = Like.find_by(book_id: params[:book_id], user_id: current_user.id)
    # @like.destroy
    # redirect_back(fallback_location: root_path)
  end
end
