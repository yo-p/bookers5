class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [ :edit, :update ] 

  def show
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have Updated User successfully."
    else
      render "edit"
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def followings
    @user = User.find(params[:user_id])
    @followings = @user.followings.where.not(id: current_user.id)
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers.where.not(id: current_user.id)
  end

  def destroy
    flash[:notice] = "Signed out successfully." 
  end

  private

  def user_params
    params.require(:user).permit( :name, :introduction, :profile_image, :postcode, :prefecture_code,
                                  :address_city, :address_street, :address_building )
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
