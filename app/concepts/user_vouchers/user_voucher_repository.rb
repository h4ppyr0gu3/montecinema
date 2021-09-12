class UserVouchers::UserVoucherRepository
	attr_reader :adapter
	def initialize adapter: UserVouchers::Model
		@adapter = adapter
	end

	def create_user_vouchers params
		adapter.create!(params)
	end

	def destroy_user_voucher id 
		adapter.where(user_id: id).destroy_all
	end
end