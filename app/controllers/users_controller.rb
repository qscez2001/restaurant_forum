class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers= @user.followers
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def friend_list
    @user = User.find(params[:id])
    # @friendings = @user.friendings
    # @frienders = @user.frienders
    @all_friends = (@user.friendings + @user.frienders).uniq
  end

  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
