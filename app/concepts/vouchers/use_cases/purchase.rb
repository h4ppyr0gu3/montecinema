class Vouchers::UseCases::Purchase
	InsufficientBalance = Class.new(StandardError)
	
	def initialize params
		@params = params
		@points_required_for_ticket
		@user
		self.points_required_for_ticket = 0
	end

	def call
		self.user = Users::UserRepository.new.find_by_id(params[:user_id])
		calculate_points_required
		validate_balance
		create_user_voucher
		update_user_attributes
	end

	private

	def calculate_points_required
		points_required_for_ticket = 0
		params[:voucher_ids].map do |id|
			voucher = Vouchers::VoucherRepository.new.find_by_id(id)
			points_required_for_ticket = voucher.points_required + points_required_for_ticket
		end
	end

	def validate_balance
		raise InsufficientBalance unless user.points_earned - points_required_for_ticket > 0
	end

	def create_user_voucher
		params[:voucher_ids].map do |id|
			UserVouchers::UserVoucherRepository.new.create_user_vouchers(
				user_id: user.id,
				voucher_id: id
			)
		end
	end

	def update_user_attributes
		update_params = Hash.new
		update_params[:points_earned] = user.points_earned - points_required_for_ticket
		update_params[:points_redeemed] = user.points_redeemed + points_required_for_ticket
		Users::UserRepository.new.update_user(params[:user_id], update_params)
	end

	attr_reader :params
	attr_accessor :points_required_for_ticket, :user
end
