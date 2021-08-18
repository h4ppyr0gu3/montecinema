require 'rails_helper'

RSpec.describe Seat, type: :model do
  before do
    create(:cinema)
  end

  it 'incorrect validations' do
    invalid_seat = Seat.new(cinema_id: Cinema.last.id, seat_number: 'a1')
    expect { invalid_seat.save! }.to raise_error ActiveRecord::RecordNotUnique
  end

  it 'correct validations' do
    create(:cinema)
    valid_seat = Seat.new(cinema_id: Cinema.first.id, seat_number: 'z1')
    valid_seat.validate
    expect(valid_seat.errors.count).to be(0)
  end
end
