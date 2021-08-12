require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  context 'with movie creation' do
    let(:movie) do
      Movie.create(
        title: 'Nuggets',
        length: '325',
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
        Movie.last.screenings.create(
          cinema_id: Cinema.last.id,
          airing_time: Time.zone.now
        )
        expect { delete :destroy, params: { id: Movie.last.id } }
        .to change{ Movie.count }.by(-1)
      end

      it 'delete screenings' do
        Movie.last.screenings.create(
          cinema_id: Cinema.last.id,
          airing_time: Time.zone.now
        )
        expect { delete :destroy, params: { id: Movie.last.id } }
        .to change{ Screening.count }.by(-1)
      end
    end
  end

  it 'POST #create' do
    expect { post :create, params: {
      title: 'Nuggets 2',
      length: '225',
      description: 'A little bit of gibberish is always good round 2',
      director: 'David Rogers',
      genre: 'The Usual'
    }, as: :json }
    .to change{ Movie.count }.by(1)
  end
end

def create_additional_movie
  Movie.create(
    title: 'Nuggets 2',
    length: '225',
    description: 'A little bit of gibberish is always good round 2',
    director: 'David Rogers',
    genre: 'The Usual'
  )
end
