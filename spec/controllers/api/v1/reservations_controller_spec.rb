require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  let(:create_reservation) do
    user = create(:user)
    movie = create(:movie)
    cinema = create(:cinema)
    screening = create(:screening, movie_id: movie.id)
    create(:reservation, user_id: user.id, screening_id: screening.id, cinema_id: cinema.id, movie_id: movie.id)
  end

  describe 'GET #index' do
    let(:index_use_case) do
      instance_double(Reservations::UseCases::Index,
                      call: { reservation: 'reservation' })
    end
    let(:index_representer) do
      instance_double(Reservations::Representers::Multiple,
                      call: { reservations: 'lots of res\'s' })
    end

    before do
      allow(Reservations::UseCases::Index).to receive(:new)
        .and_return(index_use_case)
      allow(Reservations::Representers::Multiple).to receive(:new)
        .and_return(index_representer)
    end

    context 'when no user logged in' do
      it 'returns error' do
        get :index
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end

    it 'returns reservations' do
      create(:user)
      request.headers.merge! Users::Model.last.create_new_auth_token
      get :index, params: {}
      expect(JSON.parse(response.body)).to eq('reservations' => "lots of res's")
    end
  end

  describe 'GET #show' do
    let(:show_representer) do
      instance_double(Reservations::Representers::Single,
                      call: { reservation: 'reservation' })
    end

    before do
      create_reservation
      allow(Reservations::Representers::Single).to receive(:new)
        .and_return(show_representer)
    end

    it 'returns a user reservation' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      get :show, params: { id: Reservations::Model.last.id }
      expect(JSON.parse(response.body)).to eq('reservation' => 'reservation')
    end

    it 'returns error' do
      create(:user, email: 'test1@test.com')
      request.headers.merge! Users::Model.last.create_new_auth_token
      get :show, params: { id: Reservations::Model.last.id }
      expect(JSON.parse(response.body).keys).to contain_exactly('error', 'type')
    end
  end

  describe 'POST #create' do
    let(:create_use_case) do
      instance_double(Reservations::UseCases::Create,
                      call: { reservation: 'reservation' })
    end
    let(:single_representer) do
      instance_double(Reservations::Representers::Single,
                      call: { reservation: 'created' })
    end
    let(:create_request) do
      post :create, params: {
        data: {
          attributes: {
            cinema_id: 2,
            movie_id: 10,
            seat_ids: [
              { seat_id: 1 }
            ],
            screening_id: 3,
            user_id: 4
          }
        }
      }
    end

    before do
      allow(Reservations::UseCases::Create).to receive(:new)
        .and_return(create_use_case)
      allow(Reservations::Representers::Single).to receive(:new)
        .and_return(single_representer)
    end

    it 'user creates reservation' do
      create(:user)
      request.headers.merge! Users::Model.last.create_new_auth_token
      create_request
      expect(JSON.parse(response.body)).to eq('reservation' => 'created')
    end

    it 'admin creates reservation' do
      create(:user, :admin)
      request.headers.merge! Users::Model.last.create_new_auth_token
      create_request
      expect(JSON.parse(response.body)).to eq('reservation' => 'created')
    end

    it 'require user to be logged in' do
      create_request
      expect(JSON.parse(response.body).keys).to contain_exactly('errors')
    end
  end

  describe 'PUT #update' do
    let(:update_representer) do
      instance_double(Reservations::Representers::Single,
                      call: { reservation: 'reservation' })
    end
    let(:update_use_case) do
      instance_double(Reservations::UseCases::Update,
                      call: { res: 'updated' })
    end
    let(:update_request) do
      put :update, params: {
        id: Reservations::Model.last.id,
        data: {
          attributes: {
            cinema_id: 2,
            movie_id: 3,
            screening_id: 4,
            seat_ids: [{ seat_id: 5 }]
          }
        }
      }
    end

    before do
      create_reservation
      allow(Reservations::Representers::Single).to receive(:new)
        .and_return(update_representer)
      allow(Reservations::UseCases::Update).to receive(:new)
        .and_return(update_use_case)
    end

    it 'allows correct user' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      update_request
      expect(JSON.parse(response.body)).to eq('reservation' => 'reservation')
    end

    it 'allows admin' do
      create(:user, :admin)
      request.headers.merge! Users::Model.last.create_new_auth_token
      update_request
      expect(JSON.parse(response.body)).to eq('reservation' => 'reservation')
    end

    it 'rejects incorrect user' do
      create(:user)
      request.headers.merge! Users::Model.last.create_new_auth_token
      update_request
      expect(JSON.parse(response.body).keys).to include('error')
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) { delete :destroy, params: { id: Reservations::Model.last.id } }

    before do
      create_reservation
    end

    it 'deletes reservation for user' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      expect { delete_request }.to change(Reservations::Model, :count).by(-1)
    end

    it 'deletes if admin' do
      create(:user, :admin)
      request.headers.merge! Users::Model.last.create_new_auth_token
      expect { delete_request }.to change(Reservations::Model, :count).by(-1)
    end

    it 'rejects incorrect user' do
      create(:user)
      request.headers.merge! Users::Model.last.create_new_auth_token
      expect { delete_request }.to change(Reservations::Model, :count).by(0)
    end
  end
end
