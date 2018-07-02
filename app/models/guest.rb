class Guest < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :reservations
  has_many :restaurants, through: :reservations

  accepts_nested_attributes_for :reservations
end
