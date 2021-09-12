class Vouchers::UseCases::Update
	attr_reader :params, :id
	def initialize params, id
		@params = params 
		@id = id
	end

	def call
		Vouchers::UseCases::Validate.new(params).voucher_deserializer
		voucher = Vouchers::VoucherRepository.new.update_voucher(id, params)
	end
end