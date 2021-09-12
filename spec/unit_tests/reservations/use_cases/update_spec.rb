describe Reservations::UseCases::Update do
  let(:call_class) do
    described_class.new(
      params: { args: {
        cinema_id: Cinemas::Model.last.id,
        movie_id: Movies::Model.last.id,
        screening_id: Screenings::Model.last.id,
        seat_ids: [{ seat_id: Seats::Model.first.id }]
      },
                user_id: Users::Model.last.id,
                id: Reservations::Model.last.id }
    ).call
  end

  before do
    create(:user)
    cinema = create(:cinema)
    movie = create(:movie)
    create(:screening, movie_id: movie.id, cinema_id: cinema.id)
    create_list(:seat, 10, cinema_id: cinema.id)
    create(:reservation, seat_ids: [Seats::Model.last.id])
    create(:cinema)
  end

  it 'no change in count' do
    expect { call_class }.not_to change(Reservations::Model, :count)
  end

  it 'changes seat id' do
    position_id = Positions::Model.last.id
    call_class
    expect(Positions::Model.last.id).not_to eq(position_id)
  end
end
