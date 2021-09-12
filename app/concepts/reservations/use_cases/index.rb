module Reservations
	module UseCases
		class Index < UseCase::Base
			UserNotFound = Class.new(StandardError)
			attr_reader :query, :user

			def persist
				@query = self.params[:query]
				@user = self.params[:user] 
				if user.admin? || user.support? 
					query.present? ? ReservationRepository.new.fetch_admin(
						query[:offset], query[:limit]
						) : ReservationRepository.new.fetch_all_admin
				else
					query.present? ? ReservationRepository.new.fetch(
						query[:offset], query[:limit], user
						) : ReservationRepository.new.fetch_all(user)
				end
			end
		end
	end
end
