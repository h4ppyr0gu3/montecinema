module Positions
	module UseCases
		class Create
			attr_reader :id, :seat_ids
			def initialize id, seat_ids
				@id = id 
				@seat_ids = seat_ids
			end

			def call
				seat_ids.map do |seat|
					seat_id = seat['seat_id']
					params = {reservation_id: id, seat_id: seat_id}
					PositionRepository.new.create_position(params)
				end
			end
		end
	end
end
