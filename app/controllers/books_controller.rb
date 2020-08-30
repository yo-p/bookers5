class BooksController < ApplicationController
  before_action :correct_book, only: [ :edit, :update, :destroy ]

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have creatad book successfully."
    else 
      @books = Book.all
      render "index"
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else  
      render "edit"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit( :title, :body )
  end

  def correct_book
    @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to books_path
    end
  end
end
