# frozen_string_literal: true

class Seat < ApplicationRecord
  validates :seat_number, uniqueness: { scope: :cinema_number }
end
