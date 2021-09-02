module Vouchers
	class VoucherRepository
		InvalidParams = Class.new(StandardError)
		attr_reader :adapter
		def initialize adapter: Vouchers::Model
			@adapter = adapter
		end

		def create_voucher params
			adapter.create!(params)
		rescue ActiveRecord::NotNullViolation 
			raise InvalidParams
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
		rescue ActiveRecord::RecordNotFound
			raise InvalidParams
		end

		def update_voucher id, params
			adapter.find(id).update!(params)
		end
	end
end