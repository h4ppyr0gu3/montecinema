module Seats
	module Representers
		class Relationship
			def initialize seat 
				@seat = seat 
			end

			def call
				{
					id: seat.id,
					attributes: {
						seat_number: seat.seat_number
					}
				}
			end

			private 

			attr_reader :seat
		end
	end
end