module Vouchers
	class VoucherRepository
		attr_reader :adapter
		def initialize adapter: Vouchers::Model
			@adapter = adapter
		end

		def create_voucher params
			adapter.create!(params)
		end

		def fetch offset, limit
			adapter.limit(limit).offset(offset)
		end

		def fetch_all
			adapter.all 
		end

		def pluck_params column
			adapter.pluck(column)
		end

		def find_with param 
			adapter.find_by(param)
		end

		def update_voucher id, params
			voucher = adapter.find(id)
			voucher.update!(params)
		end

		def find_by_id id
			adapter.find(id)
		end
	end
end