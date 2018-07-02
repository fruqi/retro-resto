class ReservationMailer < ApplicationMailer
  default from: 'notification@example.com'

  def reservation_email
    @reservation = params[:reservation]
    @guest = @reservation.guest
    mail(to: @guest.email, subject: 'Reservation Created!')
  end

  def update_reservation_email
    @reservation = params[:reservation]
    @previous_guest_count = @reservation.previous_changes[:guest_count][0]
    @previous_time = @reservation.previous_changes[:reservation_time][0]
    @guest = @reservation.guest
    mail(to: @guest.email, subject: 'Reservation Update')
  end
end
