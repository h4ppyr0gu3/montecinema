module Positions
	class PositionRepository
		attr_reader :repository 
		def initialize
			@repository = Positions::Model
		end

		def create_position params
			repository.create!(params)
		end

		def delete_reservation_positions reservation_id
			positions = repository.where(reservation_id: reservation_id)
			positions.each { |position| position.destroy }
		end
	end
end