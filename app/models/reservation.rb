# frozen_string_literal: true

class Reservation < ApplicationRecord
  before_save :check_restaurant_operation_hour

  belongs_to :restaurant
  belongs_to :guest
  belongs_to :table

  validates :reservation_time, presence: true
  validates :guest_count,
            presence: true,
            numericality: { greater_than: 0 }

  def guest_count=(value)
    write_attribute :guest_count, value.to_i
  end

  def check_restaurant_operation_hour
    unless restaurant.within_operation_hour?(reservation_time)
      errors.add(:reservation_time, 'Reservation must be within operation hour')
      raise ActiveRecord::RecordInvalid, self
    end
  end
end
