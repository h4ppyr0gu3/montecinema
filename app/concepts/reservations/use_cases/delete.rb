module Reservations
	module UseCases
		class Delete < UseCase::Base
			attr_reader :reservation
			def persist
				@reservation = self.params[:reservation]
				ReservationRepository.new.destroy_reservation(reservation.id)
			end
		end
	end
end
