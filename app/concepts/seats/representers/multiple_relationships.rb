module Seats
	module Representers
		class MultipleRelationships
			def initialize(seats)
				@seats = seats
			end

			def call
				serializer = 
				seats.map do |seat|
					Seats::Representers::Relationship.new(seat).call
				end
				return serializer
			end

			private

			attr_reader :seats
		end
	end
end
