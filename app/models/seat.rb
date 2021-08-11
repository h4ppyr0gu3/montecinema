# frozen_string_literal: true

class Seat < ApplicationRecord
  belongs_to :cinema
  before_validation :parse_params

  def parse_params
    self.name = self.cinema_id.to_s + self.seat_number.to_s
  end
end
