require 'rails_helper'

RSpec.describe Api::V1::CinemasController do
  describe 'POST #create' do

    subject(:create_request) do
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

    let(:create_use_case) { instance_double(Cinemas::UseCases::Create, call: {cinema: 'a', screenings: 'a', seats: 'a'}) }
    let(:single_representer) { instance_double(Cinemas::Representers::Single, call: { cinema: 'created' }) }

    before do
      allow(Cinemas::UseCases::Create).to receive(:new)
        .and_return(create_use_case)
      allow(Cinemas::Representers::Single).to receive(:new)
        .with(cinema: 'a', screenings: 'a', seats: 'a').and_return(single_representer)
    end

    context 'when regular user logged in' do 
      it 'doesn\'t allow creation' do
        create(:user)
        request.headers.merge! Users::Model.last.create_new_auth_token
        create_request
        expect(JSON.parse(response.body).keys).to include('error')
      end
    end

    context 'when admin or support user logged in' do 
      it 'allows creation' do
        create(:user, :admin)
        request.headers.merge! Users::Model.last.create_new_auth_token
        create_request
        expect(JSON.parse(response.body)).to eq({"cinema"=>"created"})
      end

      it 'allows creation' do
        create(:user, :support)
        request.headers.merge! Users::Model.last.create_new_auth_token
        create_request
        expect(JSON.parse(response.body)).to eq({"cinema"=>"created"})
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:delete_request) { delete :destroy, params: { id: Cinemas::Model.last.id } }

    let(:delete_use_case) { instance_double(Cinemas::UseCases::Delete, call: {cinema: 'cinema'}) }

    before do
      create(:cinema)
      allow(Cinemas::UseCases::Delete).to receive(:new)
      .and_return(delete_use_case)
    end

    context 'when regular user logged in' do 
      it 'doesn\'t allow deletion' do
        create(:user)
        request.headers.merge! Users::Model.last.create_new_auth_token
        delete_request
        expect(JSON.parse(response.body).keys).to include('error')
      end
    end

    context 'when admin or support user logged in' do 
      it 'allows deletion' do
        create(:user, :admin)
        request.headers.merge! Users::Model.last.create_new_auth_token
        delete_request
        expect(response.status).to eq(200)
      end

      it 'allows deletion' do
        create(:user, :support)
        request.headers.merge! Users::Model.last.create_new_auth_token
        delete_request
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #show' do 
    subject(:show_request) { get :show, params: { id: Cinemas::Model.last.id } }

    let(:show_use_case) { instance_double(Cinemas::Representers::Single, call: {cinema: 'cinema'})}

    before do 
      create(:cinema)
      allow(Cinemas::Representers::Single).to receive(:new)
      .and_return(show_use_case)
    end

    context 'when user logged in' do 
      it 'returns cinema' do 
        create(:user)
        request.headers.merge! Users::Model.last.create_new_auth_token
        show_request
        expect(JSON.parse(response.body)).to eq("cinema" => "cinema")
      end
    end

    context 'when user not logged in' do
      it 'returns error' do 
        show_request
        expect(JSON.parse(response.body).keys).to include('error')
      end
    end
  end
end
