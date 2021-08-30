require 'rails_helper'

RSpec.describe Seats::Model, type: :model do
  before do
    create(:cinema)
    create_list(:seat, 25, cinema_id: Cinemas::Model.last.id)
  end

  it 'incorrect validations' do
    invalid_seat = Seats::Model.new(
      cinema_id: Cinemas::Model.last.id, 
      seat_number: Seats::Model.last.seat_number,
      name: Seats::Model.last.name
    )
    expect { invalid_seat.save! }.to raise_error ActiveRecord::RecordNotUnique
  end

  it 'correct validations' do
    create(:cinema)
    valid_seat = Seats::Model.new(cinema_id: Cinemas::Model.first.id, seat_number: 'z1')
    expect(valid_seat.save).to eq(true)
  end
end
