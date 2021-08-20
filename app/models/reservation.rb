class Reservation < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :positions, inverse_of: :reservation, dependent: :destroy
  has_many :seats, through: :positions, dependent: :destroy

  accepts_nested_attributes_for :positions
end
