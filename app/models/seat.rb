class Seat < ApplicationRecord
  belongs_to :cinema, dependent: :destroy
  has_many :positions, dependent: :destroy, inverse_of: :seat
  has_many :reservations, through: :positions, dependent: :destroy
  before_validation :parse_params

  def parse_params
    self.name = cinema_id.to_s + seat_number.to_s
  end
end
