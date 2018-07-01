class ReservationMailer < ApplicationMailer
  default from: 'notification@example.com'

  def reservation_email
    @reservation = params[:reservation]
    @guest = @reservation.guest
    mail(to: @guest.email, subject: 'Reservation Created!')
  end

  def update_reservation_email
    @reservation = params[:reservation]
    @guest = @reservation.guest
    mail(to: @guest.email, subject: 'Reservation Update')
  end
end
