class Api::V1::VouchersController < ApplicationController

	def index
	end

	def show
	end

	def create
		voucher = Vouchers::Model.new
		authorize([:api, :v1, voucher])
		voucher = Vouchers::UseCases::Create.new(voucher_deserializer).call
		render json: Vouchers::Representers::Single.new(voucher).call, status: :created
	end

	def update
	end

	def redeem
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
end