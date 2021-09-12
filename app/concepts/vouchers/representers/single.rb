module Vouchers
	module Representers
		class Single
			attr_reader :voucher
			def initialize voucher 
				@voucher = voucher
			end

			def call
				{
					data: Vouchers::Representers::Data.new(voucher).call
				}
			end
		end
	end
end