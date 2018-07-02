# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :set_restaurant, only: [:index, :create]

  def index
    @reservations = @restaurant.reservations
    json_response(@reservations)
  end

  def create
    @reservation = @restaurant.create_reservation(guest_params, reservation_params)
    json_response(@reservation)
  end

  def update
    @reservation = @restaurant.reservations.find_by(id: params[:id])

    updated = @reservation.update(guest_count: params[:guest_count],
                                  reservation_time: params[:reservation_time])

    if updated
      ReservationMailer.with(reservation: @reservation)
                       .update_reservation_email
                       .deliver_now
    end

    json_response(@reservation)
  end

  def show
    json_response(@reservation)
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def guest_params
    params.permit(:name, :email)
  end

  def reservation_params
    params.permit(:guest_count, :reservation_time, :table_id)
  end
end
