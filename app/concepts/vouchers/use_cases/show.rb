class Vouchers::UseCases::Show
	VoucherNotFound = Class.new(StandardError)
	attr_reader :id
	def initialize id 
		@id = id 
	end

	def call
		Vouchers::VoucherRepository.new.find_by_id(id)
	rescue ActiveRecord::RecordNotFound
		raise VoucherNotFound
	end
end