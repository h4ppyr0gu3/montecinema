require 'rails_helper'

RSpec.describe Api::V1::ScreeningsController do
  context 'specs with movie creation' do
    before do 
      Movie.create(
        title: 'Nuggets',
        length: '3:25',
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
        airing_time: Time.now
      )
    end

    it 'GET #index' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(1)
      create_additional_screening
      get :index
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'GET #show' do
      create_additional_screening
      screening_id = Screening.last.id
      get :show, params: { id: screening_id }
      expect(JSON.parse(response.body).class).to eq(Hash)
    end

    it 'DELETE #destroy' do
      screening_count = Screening.count
      movie_count = Movie.count
      delete :destroy, params: {id: Screening.last.id}
      expect(Movie.count).to be == movie_count
      expect(Screening.count).to be < screening_count
    end
    
    it 'POST #create' do
      count = Screening.count
      post :create, params: { 
        movie_id: Movie.last.id,
        airing_time: 3.minutes.from_now,
        cinema_number: 5,
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
