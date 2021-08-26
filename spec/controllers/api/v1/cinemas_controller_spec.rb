require 'rails_helper'

RSpec.describe Api::V1::CinemasController do
  describe 'POST #create' do
    subject(:request) { post :create, params: {
      data: {
          type: 'cinema',
          attributes: {
            rows: 5,
            columns: 5,
            cinema_number: 1
          }
        }
      }
    }

    it 'increase cinema count' do
      expect { request }.to change(Cinemas::Model, :count).by(1)
    end

    it 'increase seat count' do
      expect { request }.to change(Seats::Model, :count).by(25)
    end
  end

  describe 'PUT #update' do 
    subject(:request) { put :update, params: { 
      id: Cinemas::Model.last.id,  
      data: {
          type: 'cinema',
          attributes: {
            rows: 10,
            columns: 5,
            cinema_number: 1
          }
        }
      }
    }

    it 'seat count increases' do 
      create(:cinema)
      create_list(:seat, 25, cinema_id: Cinemas::Model.last.id)
      expect { request }.to change(Seats::Model, :count).by(25)
    end

    it 'seat count decreases' do 
      create(:cinema, rows: 10, columns: 10)
      create_list(:seat, 100, cinema_id: Cinemas::Model.last.id)
      expect { request }.to change(Seats::Model, :count).by(-50)
    end
  end

  describe 'DELETE #destroy' do
    subject(:request) { delete :destroy, params: { id: Cinemas::Model.last.id }}

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
