module Reservations
	class ReservationRepository
    ReservationNotFound = Class.new(StandardError)
		attr_reader :repository 
		def initialize
			@repository = Reservations::Model
		end

		def create_reservation params
			repository.create!(params)
		end

		def destroy_reservation reservation 
			reservation.destroy
		end

		def find_by_id id 
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise ReservationNotFound
		end
	end
end