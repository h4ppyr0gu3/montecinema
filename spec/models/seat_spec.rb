# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seat, type: :model do
  it 'ensure stopping incorrect validations' do
    described_class.create!(cinema_number: 1, seat_number: 'a-1')
    invalid_seat = described_class.new(cinema_number: 1, seat_number: 'a-1')
    invalid_seat.validate
    expect(invalid_seat.errors[:seat_number]).to include('has already been taken')
  end

  it 'ensure passing correct validations' do
    described_class.create!(cinema_number: 1, seat_number: 'a-1')
    valid_seat = described_class.new(cinema_number: 2, seat_number: 'a-1')
    valid_seat.validate
    expect(valid_seat.errors.count).to be(0)
  end
end
