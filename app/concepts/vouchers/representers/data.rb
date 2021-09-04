class Vouchers::Representers::Data
	attr_reader :voucher 
	def initialize voucher
		@voucher = voucher
	end

	def call
		{
			type: 'voucher',
			id: voucher.id,
			attributes: {
				code: voucher.code,
				expiration_date: voucher.expiration_date,
				description: voucher.description,
				points_required: voucher.points_required
			}
		}
	end
end