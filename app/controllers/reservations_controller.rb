class ReservationsController < ApplicationController
  def index
    @reservations = Restaurant.find(params[:restaurant_id]).reservations
    json_response(@reservations)
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    guest = restaurant.guests.new(guest_params)
    guest.save

    @reservation = Reservation.create(guest_id: guest.id, restaurant_id: restaurant.id,
                                      guest_count: params[:guest_count], reservation_time: params[:reservation_time])

    if @reservation
      ReservationMailer.with(reservation: @reservation)
                       .reservation_email.deliver_now
    end

    json_response(@reservation)
  end

  def update
    restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = restaurant.reservations.find_by(id: params[:id])

    @reservation.update(guest_count: params[:guest_count],
                        reservation_time: params[:reservation_time])

    json_response(@reservation)
  end

  def destroy
  end

  def guest_params
    params.permit(:name, :email)
  end
end
