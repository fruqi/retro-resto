# frozen_string_literal: true

class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :phone_number,
            telephone_number: { country: :my, types: %i[fixed_line mobile] }

  has_many :shifts
  has_many :tables
  has_many :guests, through: :reservations

  def check_operation_hour(reservation_time)
    if shifts.empty?
      false
    else

      return false if Time.now < reservation_time

      shifts.each do |shift|
        proposed_hour = reservation_time.hour

        if proposed_hour.between?(shift.start_time, shift.end_time)
          return true
        end
      end
    end
  end
end
