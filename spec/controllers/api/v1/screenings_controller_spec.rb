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

    describe 'GET #index' do
      it 'get one entry' do
        get :index
        expect(JSON.parse(response.body).count)['data'].to eq(1)
      end

      it 'get multiple entry' do
        create_additional_screening
        get :index
        expect(JSON.parse(response.body).count)['data'].to eq(2)
      end
    end

    it 'GET #show' do
      create_additional_screening
      screening_id = Screening.last.id
      get :show, params: { id: screening_id }
      expect(JSON.parse(response.body).class).to eq(Hash)
    end

    describe 'DELETE #destroy' do
      it 'destroy screening' do
        expect { delete :destroy, params: { id: Screening.last.id } }
          .to change(Screening, :count).by(-1)
      end

      it 'doesn\'t delete movie' do
        expect { delete :destroy, params: { id: Screening.last.id } }
          .to change(Movie, :count).by(0)
      end
    end

    it 'POST #create' do
      expect do
        post :create, params:
        { screening:
          { movie_id: Movie.last.id,
            airing_time: 5.hours.from_now,
            cinema_id: Cinema.last.id } }, as: :json
      end
        .to change(Screening, :count).by(1)
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
