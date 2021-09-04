module Vouchers
	module UseCases
		class Create
			InvalidParams = Class.new(StandardError)
			attr_reader :params
			def initialize params 
				@params = params
			end

			def call
				Vouchers::VoucherRepository.new.create_voucher(params)
			end
		end
	end
end