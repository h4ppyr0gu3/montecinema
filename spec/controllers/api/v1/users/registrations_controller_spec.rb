require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController do
  describe 'POST #create' do
    let(:request) do
      post :create, params: {
        data: {
          attributes: {
            first_name: 'David',
            last_name: 'Rogers',
            email: 'test@test.com',
            password: 'test123'
          }
        }
      }, as: :json
    end

    context 'when user already created' do
      before do
        create(:user)
        request
      end

      it 'failure user already exists' do
        expect { request }.not_to change(User, :count)
      end

      it 'error message user already exists' do
        expect(
          JSON.parse(response.body)['errors'].first['detail']
        ).to eq('Email has already been taken')
      end
    end

    context 'when user logging in first time' do
      it 'creates a JTI for the user' do
        expect { request }.to change(Jti, :count).by(1)
      end

      it 'expects an Auth token to be sent' do
        expect(request.headers).to include('Authorization')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      create(:user)
      request.headers['Authorization'] =
        "Bearer #{JsonWebToken.encode(jti: User.last.jti.jti)}"
    end

    it 'delete user' do
      expect do
        delete :destroy, params: { id: User.last.id }
      end.to change(User, :count).by(-1)
    end

    it 'delete jti' do
      expect do
        delete :destroy, params: { id: User.last.id }
      end.to change(Jti, :count).by(-1)
    end
  end

  describe 'GET #show' do
    let(:show) { get :show, params: { id: User.last.id } }

    context 'logged in' do
      before do
        create(:user)
      end

      it 'correct user' do
        request.headers['Authorization'] =
          "Bearer #{JsonWebToken.encode(jti: User.last.jti.jti)}"
        show
        expect(JSON.parse(response.body)['data']['attributes']).to eq(
          {
            'first_name' => 'David',
            'last_name' => 'Rogers',
            'email' => 'test@test.com'
          }
        )
      end

      it 'incorrect user' do
        create(:user, email: 'test1@test.com')
        request.headers['Authorization'] =
          "Bearer #{JsonWebToken.encode(
            jti: User.find_by(email: 'test@test.com').jti.jti
          )}"
        show
        expect(JSON.parse(response.body)['data']['attributes']).to eq(
          {
            'first_name' => 'David',
            'last_name' => 'Rogers',
            'email' => 'test@test.com'
          }
        )
      end
    end

    context 'not logged in' do
      it 'return error' do
        create(:user)
        show
        expect(response.body).to eq('Missing token')
      end
    end
  end

  describe 'POST #update' do
    let(:update) do
      put :update, params: {
        data: {
          attributes: {
            first_name: 'Dave',
            last_name: 'Rogue'
          }
        },
        id: User.last.id
      }, as: :json
    end

    context 'all params' do
      before do
        create(:user)
        request.headers['Authorization'] =
          "Bearer #{JsonWebToken.encode(jti: User.last.jti.jti)}"
      end

      it 'doesnt change count' do
        expect { update }.to change(User, :count).by(0)
      end

      it 'updates user first_name' do
        update
        user = User.last
        expect(user.first_name).to eq('Dave')
      end

      it 'updates user last_name' do
        update
        user = User.last
        expect(user.last_name).to eq('Rogue')
      end
    end
  end
end
