module Reservations
	module UseCases
		class Delete
			attr_reader :reservation
			def initialize reservation 
				@reservation = reservation
			end

			def call
				ReservationRepository.new.destroy_reservation(reservation.id)
			end
		end
	end
end
