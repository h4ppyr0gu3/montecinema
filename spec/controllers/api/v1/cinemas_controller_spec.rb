require 'rails_helper'

RSpec.describe Api::V1::CinemasController do
  describe 'GET #index' do
    subject(:request) { get :index }

    it 'return one object' do
      create(:cinema)
      request
      expect(JSON.parse(response.body)['data'].count).to eq(1)
    end

    it 'return multiple objects' do
      create(:cinema)
      create(:cinema, cinema_number: 3)
      request
      expect(JSON.parse(response.body)['data'].count).to eq(2)
    end
  end

  it 'GET #show' do
    create(:cinema)
    create(:cinema, cinema_number: 3)
    cinema_id = Cinema.last.id
    get :show, params: { id: cinema_id }
    expect(JSON.parse(response.body).class).to eq(Hash)
  end

  it 'POST #create' do
    expect do
      post :create,
           params: {
            data: {
              type: "cinema",
              attributes: {
                rows: 10,
                columns: 10,
                cinema_number: 5
              }
            }
           }, as: :json
    end.to change(Cinema, :count).by(1)
  end

  describe 'DELETE #destroy' do
    subject(:request) { delete :destroy, params: { id: Cinema.last.id } }

    it 'delete seats' do
      create(:cinema)
      expect { request }.to change(Seat, :count).by(-25)
    end

    it 'delete cinema' do
      create(:cinema)
      expect { request }.to change(Cinema, :count).by(-1)
    end
  end
end
