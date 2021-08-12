class Seat < ApplicationRecord
  belongs_to :cinema
  before_validation :parse_params

  def parse_params
    self.name = cinema_id.to_s + seat_number.to_s
  end
end
