require 'spec_helper'

describe Reservations::UseCases::Create do
  context 'with valid parameters' do
    let(:call_class) do
      described_class.new(params: {
                            reservation: {
                              cinema_id: Cinemas::Model.last.id,
                              movie_id: Movies::Model.last.id,
                              screening_id: Screenings::Model.last.id,
                              seat_ids: [{ seat_id: Seats::Model.last.id }]
                            },
                            user_id: Users::Model.last.id
                          }).call
    end

    before do
      create(:user)
      cinema = create(:cinema)
      movie = create(:movie)
      create(:screening, movie_id: movie.id, cinema_id: cinema.id)
      create_list(:seat, 10, cinema_id: cinema.id)
    end

    it 'creates reservation' do
      expect { call_class }.to change(Reservations::Model, :count).by(1)
    end

    it 'creates positions' do
      expect { call_class }.to change(Positions::Model, :count).by(1)
    end
  end

  context 'with invalid parameters' do
    let(:call_class) do
      described_class.new(params: {
                            reservation: {
                              cinema_id: Cinemas::Model.last.id,
                              movie_id: Movies::Model.last.id,
                              screening_id: Screenings::Model.last.id,
                              seat_ids: [{ seat_id: Seats::Model.last.id }]
                            },
                            user_id: Users::Model.last.id
                          }).call
    end
    let(:call_invalid) do
      described_class.new(params: {
                            reservation: {
                              cinema_id: Cinemas::Model.last.id + 1,
                              movie_id: Movies::Model.last.id,
                              screening_id: Screenings::Model.last.id,
                              seat_ids: [{ seat_id: Seats::Model.last.id }]
                            },
                            user_id: Users::Model.last.id
                          }).call
    end

    before do
      create(:user)
      cinema = create(:cinema)
      movie = create(:movie)
      create(:screening, movie_id: movie.id, cinema_id: cinema.id)
      create_list(:seat, 10, cinema_id: cinema.id)
    end

    it 'seats can\'t overlap' do
      create(:reservation, seat_ids: [Seats::Model.last.id])
      expect { call_class }.to raise_error(Reservations::UseCases::Create::SeatAlreadyTaken)
    end

    it 'has invalid ids' do
      expect { call_invalid }.to raise_error(Cinemas::CinemaRepository::CinemaNotFound)
    end
  end
end
