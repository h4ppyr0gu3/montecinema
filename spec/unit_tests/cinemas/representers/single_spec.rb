describe Cinemas::Representers::Single do
  let(:call_class) do
    described_class.new(
      cinema: Cinemas::Model.last,
      screenings: Cinemas::Model.last.screenings,
      seats: Cinemas::Model.last.seats
    ).call
  end

  context 'with screening' do
    before do
      movie = create(:movie)
      cinema = create(:cinema)
      create(:screening,
             cinema_id: cinema.id,
             movie_id: movie.id)
      create_list(:seat, 2, cinema_id: cinema.id)
    end

    it 'has 2 seats' do
      expect(call_class[:data][:relationships][:seats].count)
        .to eq(2)
    end

    it 'has 1 screening' do
      expect(call_class[:data][:relationships][:screenings].count)
        .to eq(1)
    end
  end

  context 'without screening' do
    before do
      cinema = create(:cinema)
      create_list(:seat, 2, cinema_id: cinema.id)
    end

    it 'has no screenings' do
      expect(call_class[:data][:relationships][:screenings])
        .to eq(nil)
    end

    it 'has 2 seats' do
      expect(call_class[:data][:relationships][:seats].count)
        .to eq(2)
    end
  end
end
