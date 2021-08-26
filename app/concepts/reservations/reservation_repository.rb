module Reservations
	class ReservationRepository
		attr_reader :repository 
		def initialize
			@repository = Reservations::Model
		end

		def create_reservation params
			repository.create!(params)
		end
	end
end