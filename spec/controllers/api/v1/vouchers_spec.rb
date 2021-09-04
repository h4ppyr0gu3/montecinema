require 'rails_helper'

RSpec.describe Api::V1::VouchersController do
  describe 'POST #create' do
    let(:create_request) do
      post :create, params: {
        data: {
          attributes: {
            code: 'abcdefg',
            expiration_date: Time.zone.now,
            points_required: 10,
            description: 'popcorn + coca-cola'
          }
        }
      }
    end

    context 'authorization' do
      let(:create_use_case) { instance_double(Vouchers::UseCases::Create, call: { created: 'true' }) }
      let(:single_representer) { instance_double(Vouchers::Representers::Single, call: { voucher: 'created' }) }

      before do
        allow(Vouchers::UseCases::Create).to receive(:new)
          .and_return(create_use_case)
        allow(Vouchers::Representers::Single).to receive(:new)
          .with({ created: 'true' }).and_return(single_representer)
      end

      context 'admin user' do
        it 'creates db entry for admin user' do
          create(:user, :admin)
          request.headers.merge! Users::Model.last.create_new_auth_token
          create_request
          expect(JSON.parse(response.body)).to eq('voucher' => 'created')
        end
      end

      context 'regular user and support denied' do
        it 'creates db entry for support user' do
          create(:user, :support)
          request.headers.merge! Users::Model.last.create_new_auth_token
          create_request
          expect(JSON.parse(response.body)['error']).to match('not allowed to create? this Array')
        end

        it 'doesn\'t create db entry' do
          create(:user)
          request.headers.merge! Users::Model.last.create_new_auth_token
          create_request
          expect(JSON.parse(response.body)['error']).to match('not allowed to create? this Array')
        end
      end
    end

    it 'creates voucher' do
      create(:user, :admin)
      request.headers.merge! Users::Model.last.create_new_auth_token
      expect { create_request }.to change(Vouchers::Model, :count).by(1)
    end
  end

  describe 'GET #index' do
    let(:index_request) { get :index }
    let(:index_request_params) { get :index, params: { offset: 5, limit: 20 } }

    before do
      create(:user)
      create_list(:voucher, 30)
    end

    it 'returns all vouchers' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      index_request
      expect(JSON.parse(response.body)['data'].count).to eq(30)
    end

    it 'returns fixed number of records' do
      request.headers.merge! Users::Model.last.create_new_auth_token
      index_request_params
      expect(JSON.parse(response.body)['data'].count).to eq(20)
    end
  end

  describe 'GET #show' do
    let(:show_request) do
      get :show, params: {
        id: Vouchers::Model.last
      }
    end

    before do
      create(:user)
      create(:voucher)
    end

    it 'requires login to view' do
      show_request
      expect(JSON.parse(response.body)['error'])
        .not_to be_nil
    end

    context 'user logged in returns record' do
      it 'if the user has purchased it' do
        UserVouchers::UserVoucherRepository.new.create_user_vouchers(
          user_id: Users::Model.last.id,
          voucher_id: Vouchers::Model.last.id
        )
        request.headers.merge! Users::Model.last.create_new_auth_token
        show_request
        expect(JSON.parse(response.body)['data']['attributes']['code'])
          .to match(/^[0-9]+$/)
      end

      it 'else returns not purchased' do
        request.headers.merge! Users::Model.last.create_new_auth_token
        show_request
        expect(JSON.parse(response.body)['error'])
          .not_to be_nil
      end
    end
  end

  describe 'POST #purchase' do
    let(:purchase_request) do
      post :purchase, params: {
        data: {
          attributes: {
            user_id: Users::Model.last.id,
            voucher_ids: [Vouchers::Model.last.id]
          }
        }
      }
    end

    before do
      create(:voucher)
    end

    it 'creates purchase' do
      create(:user, points_earned: 50)
      request.headers.merge! Users::Model.last.create_new_auth_token
      purchase_request
      expect(JSON.parse(response.body)).to eq({ 'purchased' => 'success' })
    end

    it 'returns insufficient balance' do
      create(:user)
      request.headers.merge! Users::Model.last.create_new_auth_token
      purchase_request
      expect(JSON.parse(response.body)['error']).to match(/Vouchers::UseCases::Purchase::InsufficientBalance/)
    end
  end

  describe 'POST #redeem' do
    let(:redeem_request) do
      post :redeem, params: {
        data: {
          attributes: {
            user_id: Users::Model.find_by(email: 'test@test.com').id,
            voucher_ids: [Vouchers::Model.last.id]
          }
        }
      }
    end
    let(:create_purchase) do
      UserVouchers::UserVoucherRepository.new.create_user_vouchers(
        user_id: Users::Model.last.id,
        voucher_id: Vouchers::Model.last.id
      )
    end

    before do
      create(:voucher)
    end

    it 'returns success' do
      create(:user, points_earned: 50)
      create_purchase
      create(:user, :support, email: 't@t.com')
      request.headers.merge! Users::Model.find_by(email: 't@t.com').create_new_auth_token
      redeem_request
      expect(JSON.parse(response.body)).to eq({ 'success' => 'redeemed' })
    end
  end

  describe 'PUT #update' do
    before do
      create(:voucher)
    end

    let(:update_request) do
      put :update, params: {
        data: {
          attributes: {
            code: 'abcdefg',
            expiration_date: Time.zone.now + 10.days,
            points_required: 10,
            description: 'popcorn + coca-cola'
          }
        },
        id: Vouchers::Model.last.id
      }
    end

    it 'admin updates' do
      create(:user, :admin)
      request.headers.merge! Users::Model.last.create_new_auth_token
      update_request
      JSON.parse(response.body)
      expect(JSON.parse(response.body)['data']['attributes']['description'])
        .to eq('popcorn + coca-cola')
    end

    it 'refuses support user' do
      create(:user, :support)
      request.headers.merge! Users::Model.last.create_new_auth_token
      update_request
      expect(JSON.parse(response.body)['error']).to eq('not allowed to update? this Array')
    end
  end
end
