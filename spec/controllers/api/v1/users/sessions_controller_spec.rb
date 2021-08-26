require 'rails_helper'

RSpec.describe Api::V1::Override::SessionsController do
  describe 'POST #create' do
    let(:request) do
      post :create,
           params: {
             data: {
               type: 'user',
               attributes: {
                 email: 'test@test.com',
                 password: 'test123'
               }
             }
           }, as: :json
    end

    context 'when user exists' do
      before do
        user = create(:user)
        # user.jti.destroy
      end

      it 'Jti doesn\'t change' do
        jti = User.last.jti.jti
        request
        expect(jti).to eq(User.last.jti.jti)
      end

      it 'User count is the same' do
        expect { request }.not_to change(User, :count)
      end
    end

    context 'when user doesn\'t exist ' do
      it 'returns error' do
        request
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_request) { delete :destroy, params: { id: user.id } }

    let(:user) { create(:user) }

    before do
      request.headers['Authorization'] =
        "Bearer #{JsonWebToken.encode(jti: user.jti.jti)}"
    end

    it 'ensures jti is destroyed' do
      expect { destroy_request }.to change(Jti, :count).by(-1)
    end

    it 'ensure user isnt destroyed' do
      expect { destroy_request }.not_to change(User, :count)
    end
  end
end
