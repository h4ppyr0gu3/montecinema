class Vouchers::UseCases::Redeem
	attr_reader :params
	def initialize params
		@params = params
	end

	def call
		Vouchers::UseCases::Validate.new(params).redeem_params
		user = Users::UserRepository.find_by_id(params[:user_id])
		voucher = Vouchers::VoucherRepository.find_with(code: params[:voucher_code])
		if user.points_earned - voucher.points_required > 0
			update_params[:points_earned] = user.points_earned - voucher.points_required
			update_params[:points_redeemed] = user.points_redeemed + voucher.points_required
			Users::UserRepository.update_user(params[:user_id], update_params)
		else 
			raise InvalidParams
		end
	end
end