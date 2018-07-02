# frozen_string_literal: true

class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :phone_number,
            telephone_number: { country: :my, types: %i[fixed_line mobile] }

  has_many :reservations
  has_many :guests, through: :reservations
  has_many :shifts
  has_many :tables

  accepts_nested_attributes_for :reservations

  def create_reservation(guest_params, reservation_params)
    guest = guests.new(guest_params)
    guest.save!

    @reservation = reservations.new(reservation_params)
    @reservation.guest_id = guest.id
    @reservation.save!

    unless @reservation.errors.any?
      ReservationMailer.with(reservation: @reservation).reservation_email.deliver_now
    end

    @reservation
  end

  def within_operation_hour?(reservation_time)
    if shifts.empty?
      false
    else
      # return false if Time.now < reservation_time
      within_operation_hour = false

      shifts.each do |shift|
        proposed_hour = reservation_time.hour

        if proposed_hour.between?(shift.start_time, shift.end_time)
          within_operation_hour = true
        end
      end

      within_operation_hour
    end
  end
end
