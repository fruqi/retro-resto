class Shift < ApplicationRecord
  validates :start_time,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 23
            }

  validates :end_time,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 23
            }
  belongs_to :restaurant
end
