class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :update, :destroy]
  before_action :set_restaurant, only: [:index, :create]

  def index
    @shifts = @restaurant.shifts
    json_response(@shifts)
  end

  def create
    @shift = @restaurant.shifts.create!(shift_params)
    json_response(@shift, :created)
  end

  def show
    json_response(@shift)
  end

  def update
    @shift.update(shift_params)
  end

  def destroy
    @shift.destroy
    head :no_content
  end

  def shift_params
    params.permit(:start_time, :end_time)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
