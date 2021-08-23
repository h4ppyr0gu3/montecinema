module Screenings
	module Representers
		class Single
			def initialize screening
				@screening = screening 
			end

			def call
				serializer =
				{
					data: {
						id: screening.id,
						type: 'screening',
						attributes: {
							airing_time: screening.airing_time,
							additional_cost: screening.additional_cost,
							seats_available: screening.seats_available,
							movie_id: screening.movie_id
						}
					}
				}
				return serializer
			end

			private

			attr_reader :screening
		end
	end
end
