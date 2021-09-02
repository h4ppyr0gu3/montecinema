class Api::V1::VouchersController < ApplicationController

	def index
		vouchers = Vouchers::UseCases::Index.new(params).call
		render json: Vouchers::Representers::Multiple.new(vouchers).call
	end

	def show
		voucher = Vouchers::UseCases::Show.new(params[:id]).call
		render json: Vouchers::Representers::Single.new(voucher).call
	end

	def create
		voucher = Vouchers::Model.new
		authorize([:api, :v1, voucher])
		voucher = Vouchers::UseCases::Create.new(voucher_deserializer).call
		render json: Vouchers::Representers::Single.new(voucher).call, status: :created
	end

	def redeem
		voucher = Vouchers::Model.new
		authorize([:api, :v1, voucher])
		redeem = Vouchers::UseCases::Redeem.new(redeem_params).call
		render json: { success: 'redeemed' }
	end

	def update
		voucher = Vouchers::Model.new
		authorize([:api, :v1, voucher])
		voucher = Vouchers::UseCases::Update.new(voucher_deserializer, params[:id]).call 
		render json: Vouchers::Representers::Single.new(voucher).call
	end


	private

	def voucher_deserializer
		{
      points_required: params['data']['attributes']['points_required'],
      expiration_date: params['data']['attributes']['expiration_date'],
      code: params['data']['attributes']['code'],
      description: params['data']['attributes']['description'],
      value: params['data']['attributes']['value'],
    }		
	end

	def redeem_params
		{
			user_id: params['data']['attributes']['user_id'],
			voucher_code: params['data']['attributes']['voucher_code']
		}
	end
end