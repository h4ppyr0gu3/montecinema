class Api::v1::VouchersController < ApplicationController

	def create
		voucher = Voucher.new(voucher_params)
		if voucher.save 
			render json: voucher 
		else 
			render json: voucher.errors
		end
	end

	def redeem
		current_user.increment(:points_redeemed, by = voucher[:points_required])
		current_user.decrement(:points_earned, by = voucher[:points_required])
	end

	private

	def set_voucher
		@voucher = Voucher.find(params[:id])
	end

	def voucher_params
		params.require(:voucher).permit(:code, :expiration_date, :points_required)
	end
end