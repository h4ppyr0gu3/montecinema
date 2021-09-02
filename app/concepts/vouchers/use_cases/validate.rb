class Vouchers::UseCases::Validate
	InvalidParams = Class.new(StandardError)
	attr_reader :params
	def initialize params
		@params = params
	end

	def voucher_deserializer
		raise InvalidParams unless params[:points_required] > 0
    raise InvalidParams unless params[:expiration_date] > Time.zone.now + 1.day
    raise InvalidParams unless params[:description].length > 250
    while Vouchers::VoucherRepository.new.pluck_params(:code).include? params[:code]
    	params[:code] = SecureRandom.alphanumeric(6)
    end
    params
	end

	def redeem_params
		if params[:user_id].present?
			Users::UserRepository.new.find_by_id(params[:user_id])
		end
		voucher = Vouchers::VoucherRepository.new.find_with(code: params[:voucher_code])
		raise InvalidParams unless voucher.active
		params
	rescue Users::UserRepository::UserNotFound
		raise InvalidParams
	rescue Vouchers::VoucherRepository::InvalidParams
		raise InvalidParams
	end
end