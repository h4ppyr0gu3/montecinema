module Vouchers
	module Representers
		class Single
			attr_reader :voucher
			def initialize voucher 
				@voucher = voucher
			end

			def call
				{
					data: {
						type: 'voucher',
						id: voucher.id,
						attributes: {
							code: voucher.code,
							expiration_date: voucher.expiration_date,
							value: voucher.value,
							description: voucher.description,
							points_required: voucher.points_required
						}
					}
				}
			end
		end
	end
end