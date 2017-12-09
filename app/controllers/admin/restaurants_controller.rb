class Admin::RestaurantsController < ApplicationController
before_action :authenticate_user! 
before_action :authenticate_admin

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path(@restaurant)
      flash[:notice] = "restaurant was successfully updated"
    else
      # 重新呼叫
      render :edit
      flash[:alert] = "restaurant was failed to update"
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end

  private


  # 在讀取表單資料時，基於安全考量，必須在參數傳入時多做一層處理，術語叫做 Strong Parameters，Rails 4 以上的版本強制要求加入此程序。
  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
