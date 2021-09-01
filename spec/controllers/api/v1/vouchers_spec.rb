require 'rails_helper'

RSpec.describe Api::V1::VouchersController do
	describe 'POST #create' do 
		let(:create_request) {
			post :create, params: {
        data: {
          attributes: {
            code: 'abcdefg',
      			expiration_date: Time.zone.now,
      			points_required: 10,
      			description: 'popcorn + coca-cola',
      			value: 0
          }
        }
      }
		}
		let(:create_use_case) { instance_double(Vouchers::UseCases::Create, call: {created: 'true'}) }
		let(:single_representer) { instance_double(Vouchers::Representers::Single, call: {voucher: "created"}) }
		before do 
    	allow(Vouchers::UseCases::Create).to receive(:new)
    	.and_return(create_use_case)
    	allow(Vouchers::Representers::Single).to receive(:new)
    	.with({created: 'true'}).and_return(single_representer)
    end

		context 'admin and support user' do
			it 'creates db entry for admin user' do 
				create(:user, :admin)
				request.headers.merge! Users::Model.last.create_new_auth_token
				create_request
				expect(JSON.parse(response.body)).to eq("voucher" => "created")
			end 

			it 'creates db entry for support user' do 
				create(:user, :support)
				request.headers.merge! Users::Model.last.create_new_auth_token
				create_request
				expect(JSON.parse(response.body)).to eq("voucher" => "created")
			end
		end

		context 'regular user denied' do 
			it 'doesn\'t create db entry' do 
				create(:user)
				request.headers.merge! Users::Model.last.create_new_auth_token
				expect { create_request }.to raise_error( Pundit::NotAuthorizedError)
			end
		end
	end
end
