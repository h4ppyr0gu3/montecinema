require 'rails_helper'

RSpec.describe Api::V1::ScreeningsController do
  context 'with movie creation' do
    before do
      Movie.create(
        title: 'Nuggets',
        length: '1:25',
        description: 'A little bit of gibberish is always good i guess',
        director: 'David Rogers',
        genre: 'The Usual'
      )
      Cinema.create(
        cinema_number: 5
      )
      Screening.create(
        cinema_id: Cinema.last.id,
        movie_id: Movie.last.id,
        airing_time: Time.zone.now
      )
    end

    context 'when GET #index' do
      it 'get one entry' do
        get :index
        expect(JSON.parse(response.body).count).to eq(1)
      end

      it 'get multiple entry' do
        create_additional_screening
        get :index
        expect(JSON.parse(response.body).count).to eq(2)
      end
    end

    it 'GET #show' do
      create_additional_screening
      screening_id = Screening.last.id
      get :show, params: { id: screening_id }
      expect(JSON.parse(response.body).class).to eq(Hash)
    end

    context 'when DELETE #destroy' do
      it 'destroy screening' do
        screening_count = Screening.count
        delete :destroy, params: { id: Screening.last.id }
        expect(Screening.count).to be < screening_count
      end

      it 'doesn\'t delete movie' do
        movie_count = Movie.count
        delete :destroy, params: { id: Screening.last.id }
        expect(Movie.count).to be == movie_count
      end
    end

    it 'POST #create' do
      count = Screening.count
      post :create, params: {
        movie_id: Movie.last.id,
        airing_time: 5.hours.from_now,
        cinema_number: 5
      }, as: :json
      expect(count).to eql(Screening.count - 1)
    end
  end
end

def create_additional_screening
  Screening.create(
    cinema_id: Cinema.last.id,
    movie_id: Movie.last.id,
    airing_time: 5.hours.from_now
  )
end
