module Cinemas
	module Representers
		class Single
			def initialize(cinema)
				@cinema = cinema
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
							seats: [Seats::Representers::MultipleRelationships.new(
								Seats::SeatRepository.new.fetch_cinema_seats(cinema.id)
								).call],
							screenings: [
								if cinema.screenings.present?
									Screenings::Representers::MultipleRelationships.new(cinema.screenings).call
								end
							]
						}
					}
				}
			end

			private

			attr_reader :cinema
		end
	end
end