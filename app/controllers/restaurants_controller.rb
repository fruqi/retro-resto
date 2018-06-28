class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.all
    json_response(@restaurants)
  end

  def show
    json_response(@restaurant)
  end

  def create
    @restaurant = Restaurant.create!(restaurant_params)
    json_response(@restaurant, :created)
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  def update
    @restaurant.update(restaurant_params)
  end

  def restaurant_params
    params.permit(:name, :email, :phone_number)
  end
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
