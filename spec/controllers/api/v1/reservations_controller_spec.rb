require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  let(:reservation) do
    Reservations::UseCases::Create.new({
                                         cinema_id: Cinemas::Model.last.id,
                                         movie_id: Movies::Model.last.id,
                                         screening_id: Screenings::Model.last.id,
                                         seat_ids: [{ seat_id: Seats::Model.first.id }]
                                       }, Users::Model.last.id).call
  end

  before do
    create(:movie)
    create(:cinema)
    create(:screening)
    create_list(:seat, 25, cinema_id: Cinemas::Model.last.id)
    create(:user)
  end

  describe 'GET #index' do
    context 'when no user logged in' do
      it 'expects one record' do
        get :index
        expect(JSON.parse(response.body)).to include(match(/errors/) => Array)
      end
    end

    it 'returns all user reservations' do
      Reservations::UseCases::Create.new({
                                           cinema_id: Cinemas::Model.last.id,
                                           movie_id: Movies::Model.last.id,
                                           screening_id: Screenings::Model.last.id,
                                           seat_ids: [{ seat_id: Seats::Model.last.id }]
                                         }, Users::Model.last.id).call
      request.headers.merge! Users::Model.last.create_new_auth_token
      get :index
      expect(JSON.parse(response.body)['data'].count).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns a single reservation' do
      reservation
      request.headers.merge! Users::Model.last.create_new_auth_token
      get :show, params: { id: Reservations::Model.last.id }
      expect(JSON.parse(response.body)['data'].class).to eq(Hash)
    end
  end

  describe 'POST #create' do
    it 'creates reservation for user' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      post :create, params: {
        data: {
          attributes: {
            cinema_id: Cinemas::Model.last.id,
            movie_id: Movies::Model.last.id,
            screening_id: Screenings::Model.last.id,
            seat_ids: [{ seat_id: Seats::Model.first.id }]
          }
        }
      }
      expect(Users::Model.last.reservations.count).to eq(1)
    end
  end

  describe 'PUT #update' do
    before do
      reservation
    end

    it 'doesnt change position count' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      put :update, params: { id: Reservations::Model.last.id,
                             data: {
                               attributes: {
                                 cinema_id: Cinemas::Model.last.id,
                                 movie_id: Movies::Model.last.id,
                                 screening_id: Screenings::Model.last.id,
                                 seat_ids: [{ seat_id: Seats::Model.last.id }]
                               }
                             } }
      expect(Positions::Model.count).to eq(1)
    end

    it 'change seat number' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      put :update, params: { id: Reservations::Model.last.id,
                             data: {
                               attributes: {
                                 cinema_id: Cinemas::Model.last.id,
                                 movie_id: Movies::Model.last.id,
                                 screening_id: Screenings::Model.last.id,
                                 seat_ids: [{ seat_id: Seats::Model.last.id }]
                               }
                             } }
      expect(Positions::Model.last.seat_id).to eq(Seats::Model.last.id)
    end
  end

  describe 'DELETE #destroy' do
    before do
      reservation
    end

    it 'deletes positions' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      expect do
        delete :destroy, params: { id: Reservations::Model.last.id }
      end.to change(Positions::Model, :count).by(-1)
    end

    it 'deletes reservation' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      expect do
        delete :destroy, params: { id: Reservations::Model.last.id }
      end.to change(Reservations::Model, :count).by(-1)
    end
  end
end
