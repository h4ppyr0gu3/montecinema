module Reservations
	module UseCases
		class Index
			UserNotFound = Class.new(StandardError)
			attr_reader :params, :user
			def initialize params, user 
				@params = params
				@user = user 
			end

			def call
				raise UserNotFound unless user.present?
				params.present? ? ReservationRepository.new.fetch(
					params[:offset], params[:limit], user
					) : ReservationRepository.new.(user).fetch_all
			end
		end
	end
end
