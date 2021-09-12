module Cinemas
	module Representers
		class Single
			def initialize cinema:, screenings:, seats:
				@cinema = cinema
				@screenings = screenings 
				@seats = seats
			end

			def call
				{
					data: {
						type: 'cinema',
						id: cinema.id,
						attributes: {
							cinema_number: cinema.cinema_number,
							rows: cinema.rows,
							columns: cinema.columns,
							total_seats: cinema.total_seats
						},
						relationships: {
							seats: Seats::Representers::MultipleRelationships.new(
								seats
								).call,
							screenings:
								if screenings.present?
									Screenings::Representers::MultipleRelationships.new(screenings).call
								end
						}
					}
				}
			end

			private

			attr_reader :cinema, :screenings, :seats
		end
	end
end