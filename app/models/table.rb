class Table < ApplicationRecord
  validates :name,
            presence: true

  validates :min_guest,
            presence: true,
            numericality: { greater_than: 0 }

  validates :max_guest,
            presence: true,
            numericality: { greater_than: 0 }

  belongs_to :restaurant
end
