# frozen_string_literal: true

def seed_cinema(rows, columns, cinema_number)
  cols = ("a".."z").take(columns).to_a
  rows = (1..rows).to_a
  seats = cols.product(rows).map(&:join)
  seats.each do |seat_number|
    seat = Seat.new(cinema_number: cinema_number, seat_number: seat_number)
    if seat.save
      Rails.logger.info "cinema_number: #{cinema_number}, seat_number: #{seat_number}"
    elsif seat.errors.any?
      Rails.logger.error seat.errors.messages
    end
  end
end

cinemas = [
  [10, 20, 1],
  [10, 10, 2],
  [10, 10, 3],
  [10, 10, 4],
  [10, 10, 5],
  [5, 10, 6],
  [5, 10, 7],
  [5, 10, 8],
  [5, 10, 9],
  [5, 4, 10]
]

cinemas.each do |cinema|
  seed_cinema(cinema[0], cinema[1], cinema[2])
end
