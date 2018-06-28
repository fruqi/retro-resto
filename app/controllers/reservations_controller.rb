class ReservationsController < ApplicationController
  def index
    @reservations = Restaurant.find(params[:restaurant_id]).guests
    json_response(@reservations)
  end

  def create
    @reservation = Reservation.create_reservation
  end

  def update
  end

  def destroy
  end
end
