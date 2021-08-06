# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seat, type: :model do
  it 'ensure stopping incorrect validations' do
    Seat.create!(cinema_number: 1, seat_number: 'a-1')
    invalid_seat = Seat.new(cinema_number: 1, seat_number: 'a-1')
    invalid_seat.validate
    expect(invalid_seat.errors[:seat_number]).to include('has already been taken')
  end

  it 'ensure passing correct validations' do
    Seat.create!(cinema_number: 1, seat_number: 'a-1')
    valid_seat = Seat.new(cinema_number: 2, seat_number: 'a-1')
    valid_seat.validate
    expect(valid_seat.errors.count).to eql(0)
  end
end
