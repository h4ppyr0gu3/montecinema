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

    context 'authorization' do 
	    let(:create_use_case) { instance_double(Vouchers::UseCases::Create, call: {created: 'true'}) }
			let(:single_representer) { instance_double(Vouchers::Representers::Single, call: {voucher: "created"}) }
			before do 
	    	allow(Vouchers::UseCases::Create).to receive(:new)
	    	.and_return(create_use_case)
	    	allow(Vouchers::Representers::Single).to receive(:new)
	    	.with({created: 'true'}).and_return(single_representer)
	    end

			context 'admin user' do
				it 'creates db entry for admin user' do 
					create(:user, :admin)
					request.headers.merge! Users::Model.last.create_new_auth_token
					create_request
					expect(JSON.parse(response.body)).to eq("voucher" => "created")
				end 
			end

			context 'regular user and support denied' do 
				it 'creates db entry for support user' do 
					create(:user, :support)
					request.headers.merge! Users::Model.last.create_new_auth_token
					expect { create_request }.to raise_error( Pundit::NotAuthorizedError)
				end

				it 'doesn\'t create db entry' do 
					create(:user)
					request.headers.merge! Users::Model.last.create_new_auth_token
					expect { create_request }.to raise_error( Pundit::NotAuthorizedError)
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
		let(:index_request_params) { get :index, params: {offset: 5, limit: 20} }

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
end
