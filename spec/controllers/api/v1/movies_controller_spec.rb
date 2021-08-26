require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  describe 'with movie creation' do
    before do
      create(:movie)
    end

    describe 'GET #index' do
      subject(:request) { get :index }

      it 'return one item' do
        request
        expect(JSON.parse(response.body)['data'].count).to eq(1)
      end

      it 'return multiple items' do
        create(:movie, title: 'something Else', length: 134)
        request
        expect(JSON.parse(response.body)['data'].count).to eq(2)
      end
    end

    it 'GET #show' do
      create(:movie)
      get :show, params: { id: Movies::Model.last.id }
      expect(JSON.parse(response.body).class).to eq(Hash)
    end

    describe 'DELETE #destroy' do
      before do
        create(:cinema)
      end

      it 'deletes movies' do
        Movies::Model.last.screenings.create(
          cinema_id: Cinemas::Model.last.id,
          airing_time: Time.zone.now
        )
        expect { delete :destroy, params: { id: Movies::Model.last.id } }
          .to change(Movies::Model, :count).by(-1)
      end

      it 'delete screenings' do
        Movies::Model.last.screenings.create(
          cinema_id: Cinemas::Model.last.id,
          airing_time: Time.zone.now
        )
        expect { delete :destroy, params: { id: Movies::Model.last.id } }
          .to change(Screenings::Model, :count).by(-1)
      end
    end
  end

  it 'POST #create' do
    expect do
      post :create, params: {
        data: {
          type: 'movie',
          attributes: {
            title: 'Nuggets 2',
            length: '225',
            description: 'A little bit of gibberish is always good round 2',
            director: 'David Rogers',
            genre: 'The Usual'
          }
        }
      }, as: :json
    end
      .to change(Movies::Model, :count).by(1)
  end
end
