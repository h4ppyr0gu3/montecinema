require 'rails_helper'

RSpec.describe Api::V1::CinemasController do
  describe 'POST #create' do
    subject(:request) do
      post :create, params: {
        data: {
          type: 'cinema',
          attributes: {
            rows: 5,
            columns: 5,
            cinema_number: 1
          }
        }
      }
    end

    it 'increase cinema count' do
      expect { request }.to change(Cinemas::Model, :count).by(1)
    end

    it 'increase seat count' do
      expect { request }.to change(Seats::Model, :count).by(25)
    end
  end

  describe 'DELETE #destroy' do
    subject(:request) { delete :destroy, params: { id: Cinemas::Model.last.id } }

    it 'delete seats' do
      create(:cinema)
      create_list(:seat, 25, cinema_id: Cinemas::Model.last.id)
      expect { request }.to change(Seats::Model, :count).by(-25)
    end

    it 'delete cinema' do
      create(:cinema)
      expect { request }.to change(Cinemas::Model, :count).by(-1)
    end
  end
end
