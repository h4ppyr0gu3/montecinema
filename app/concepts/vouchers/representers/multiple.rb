class Vouchers::Representers::Multiple 
	attr_reader :vouchers
	def initialize vouchers
		@vouchers = vouchers
	end

	def call
		{
			data: vouchers.map do |voucher|
				Vouchers::Representers::Data.new(voucher).call
			end
		}
	end
end
