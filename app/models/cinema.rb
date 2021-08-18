class Cinema < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :screenings, dependent: :delete_all
  validates :cinema_number, uniqueness: true
  before_create :add_total_seats
  after_create :create_seats

  private

  def create_seats
    cols = ('a'..'z').take(columns).to_a
    rows = (1..(self.rows)).to_a
    seats = cols.product(rows).map(&:join)
    seats.each do |seat_number|
      seat = self.seats.new(seat_number: seat_number)
      Rails.logger.error seat.errors.messages unless seat.save!
    end
  end

  def add_total_seats
    self.total_seats = rows * columns
  end
end
