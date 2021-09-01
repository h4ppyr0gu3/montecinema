module Vouchers
	class VoucherRepository
		InvalidParams = Class.new(StandardError)
		attr_reader :repository
		def initialize
			@repository = Vouchers::Model 
		end

		def create_voucher params
			repository.create!(params)
		rescue ActiveRecord::NotNullViolation 
			raise InvalidParams
		end
	end
end