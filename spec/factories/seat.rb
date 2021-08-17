FactoryBot.define do
  factory :seat, class: 'Seat' do
    # association :cinema, factory: :cinema
    # cols = ('a'..'z').take(5).to_a
    # rows = (1..(5)).to_a
    # seats = cols.product(rows).map(&:join)
    # seats.each do |seat_number|
    #   seat = Seat.new(seat_number: seat_number)
    #   puts seat.errors.messages unless seat.save!
    # end
  end
end
