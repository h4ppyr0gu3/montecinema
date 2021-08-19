require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController do
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
    let(:destroy_request) { delete :destroy, params: { id: User.last.id } }
    let(:headers) do
      request.headers['Authorization'] =
        "Bearer #{JsonWebToken.encode(jti: User.last.jti.jti)}"
    end

    it 'ensures jti is destroyed' do
      create(:user)
      expect do
        headers
        destroy_request
      end.to change(Jti, :count).by(-1)
    end

    it 'ensure user isnt destroyed' do
      create(:user)
      expect do
        headers
        destroy_request
      end.not_to change(User, :count)
    end
  end
end
