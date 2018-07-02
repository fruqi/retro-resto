# frozen_string_literal: true

class ReservationsController < ApplicationController
  def index
    @reservations = Restaurant.find(params[:restaurant_id]).reservations
    json_response(@reservations)
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = restaurant.create_reservation(guest_params, reservation_params)

    json_response(@reservation)
  end

  def update
    restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = restaurant.reservations.find_by(id: params[:id])

    updated = @reservation.update(guest_count: params[:guest_count],
                                  reservation_time: params[:reservation_time])

    if updated
      ReservationMailer.with(reservation: @reservation)
                       .update_reservation_email
                       .deliver_now
    end

    json_response(@reservation)
  end

  def destroy
  end

  def guest_params
    params.permit(:name, :email)
  end

  def reservation_params
    params.permit(:guest_count, :reservation_time, :table_id)
  end
end
