module Cinemas
	module Representers
		class Relationship
			attr_reader :cinema
			def initialize cinema:
				@cinema = cinema
			end

			def call
				{
					type: 'cinema',
					id: cinema.id,
					attributes: {
						cinema_number: cinema.cinema_number,
						total_seats: cinema.total_seats,
						rows: cinema.rows,
						columns: cinema.columns
					}
				}
			end
		end
	end
end