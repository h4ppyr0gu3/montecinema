require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  context 'with movie creation' do
    let(:movie) do
      Movie.create(
        title: 'Nuggets',
        length: '3:25',
        description: 'A little bit of gibberish is always good i guess',
        director: 'David Rogers',
        genre: 'The Usual'
      )
    end

    before do
      movie
    end

    context 'when GET #index' do
      subject { get :index }

      it 'return one item' do
        subject
        expect(JSON.parse(response.body).count).to eq(1)
      end

      it 'return multiple items' do
        create_additional_movie
        subject
        expect(JSON.parse(response.body).count).to eq(2)
      end
    end

    it 'GET #show' do
      create_additional_movie
      movie_id = Movie.last.id
      get :show, params: { id: movie_id }
      expect(JSON.parse(response.body).class).to eq(Hash)
    end

    context 'when DELETE #destroy' do
      before do
        Cinema.create(cinema_number: 1)
      end

      it 'deletes movies' do
        screening = Movie.last.screenings.new(
          cinema_id: Cinema.last.id,
          airing_time: Time.zone.now
        )
        screening.save
        movie_count = Movie.count
        delete :destroy, params: { id: Movie.last.id }
        expect(Movie.count).to be < movie_count
      end

      it 'delete screenings' do
        screening = Movie.last.screenings.new(
          cinema_id: Cinema.last.id,
          airing_time: Time.zone.now
        )
        screening.save
        screening_count = Screening.count
        delete :destroy, params: { id: Movie.last.id }
        expect(Screening.count).to be < screening_count
      end
    end
  end

  it 'POST #create' do
    count = Movie.count
    post :create, params: {
      title: 'Nuggets 2',
      length: '2:25',
      description: 'A little bit of gibberish is always good round 2',
      director: 'David Rogers',
      genre: 'The Usual'
    }, as: :json
    expect(count).to eql(Movie.count - 1)
  end
end

def create_additional_movie
  Movie.create(
    title: 'Nuggets 2',
    length: '2:25',
    description: 'A little bit of gibberish is always good round 2',
    director: 'David Rogers',
    genre: 'The Usual'
  )
end
