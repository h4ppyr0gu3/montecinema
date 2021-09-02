class Vouchers::UseCases::Index
	attr_reader :params, :user
	def initialize params
		@params = params
	end

	def call
		params.present? ? Vouchers::VoucherRepository.new.fetch(
		params[:offset], params[:limit]
		) : Vouchers::VoucherRepository.new.fetch_all
	end
end