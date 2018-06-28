# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :guest

  validates :reservation_time, presence: true

  validates :guest_count,
            presence: true,
            numericality: { greater_than: 0 }

  def self.create_reservation(restaurant_id, user_id, guest_count, reservation_time)
    restaurant = Restaurant.find(restaurant_id)
    guest = Guest.find(user_id)

    if restaurant.check_operation_hour(reservation_time)
      create(guest_id: guest.id, restaurant_id: restaurant.id,
             guest_count: guest_count, reservation_time: reservation_time)
    end
  end
end
