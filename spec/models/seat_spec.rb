require 'rails_helper'

RSpec.describe Seat, type: :model do
  before do
    Cinema.create(cinema_number: 10)
  end

  it 'incorrect validations' do
    seat = Seat.create(cinema_id: Cinema.last.id, seat_number: 'a1')
    invalid_seat = Seat.new(cinema_id: Cinema.last.id, seat_number: 'a1')
    expect { invalid_seat.save! }.to raise_error ActiveRecord::RecordNotUnique
  end

  it 'correct validations' do
    Cinema.create(cinema_number: 8)
    Seat.create!(cinema_id: Cinema.last.id, seat_number: 'a1')
    valid_seat = Seat.new(cinema_id: Cinema.first.id, seat_number: 'a1')
    valid_seat.validate
    expect(valid_seat.errors.count).to be(0)
  end
end