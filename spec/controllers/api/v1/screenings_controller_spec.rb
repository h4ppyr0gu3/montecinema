require 'rails_helper'

RSpec.describe Api::V1::ScreeningsController do
  context 'with movie creation' do
    before do
      create(:movie)
      create(:cinema)
      create(:screening)
    end

    describe 'GET #index' do
      it 'get one entry' do
        get :index
        expect(JSON.parse(response.body)['data'].count).to eq(1)
      end

      it 'get multiple entry' do
        create_additional_screening
        get :index
        expect(JSON.parse(response.body)['data'].count).to eq(2)
      end
    end

    it 'GET #show' do
      create_additional_screening
      screening_id = Screenings::Model.last.id
      get :show, params: { id: screening_id }
      expect(JSON.parse(response.body).class).to eq(Hash)
    end

    describe 'DELETE #destroy' do
      it 'destroy screening' do
        expect { delete :destroy, params: { id: Screenings::Model.last.id } }
          .to change(Screenings::Model, :count).by(-1)
      end

      it 'doesn\'t delete movie' do
        expect { delete :destroy, params: { id: Screenings::Model.last.id } }
          .to change(Movies::Model, :count).by(0)
      end
    end

    it 'POST #create' do
      create(:movie)
      create(:cinema)
      expect do
        post :create, params: {
          data: {
            type: 'screening',
            attributes: {
              movie_id: Movies::Model.last.id,
              airing_time: 5.hours.from_now,
              cinema_id: Cinemas::Model.last.id
            }
          }
        }, as: :json
      end
        .to change(Screenings::Model, :count).by(1)
    end
  end
end

def create_additional_screening
  Screenings::Model.create(
    cinema_id: Cinemas::Model.last.id,
    movie_id: Movies::Model.last.id,
    airing_time: 5.hours.from_now
  )
end
