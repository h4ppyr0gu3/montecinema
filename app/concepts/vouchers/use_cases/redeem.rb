class Vouchers::UseCases::Redeem
	attr_reader :params
	def initialize params
		@params = params
	end

	def call
		Vouchers::UseCases::Validate.new(params).redeem_params
		UserVouchers::UserVoucherRepository.new.destroy_user_voucher(params[:user_id])
	end
end
