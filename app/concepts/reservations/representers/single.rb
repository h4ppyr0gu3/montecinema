module Reservations
	module Representers
		class Single
			attr_reader :reservation
			def initialize reservation 
				@reservation = reservation
			end

			def call 
				puts reservation.seats
				{
					data: {
						type: 'reservation',
						attributes: {},
						relationships: {
							user: Users::Representers::Relationship.new(
								Users::UserRepository.new.find_by_id(reservation['user_id'])
							),
							movie: Movies::Representers::Relationship.new(
								Movies::MovieRepository.new.find_by_id(reservation.movie_id)
							),
							screening: Screenings::Representers::Relationship.new(
								Screenings::ScreeningRepository.new.find_by_id(reservation.screening_id)
							),
							cinema: Cinemas::Representers::Relationship.new(
								Cinemas::CinemaRepository.new.find_by_id(reservation.cinema_id)
							),
							seats: Seats::Representers::MultipleRelationships.new(
								reservation.seats
							)
						}
					}
				}
			end
		end
	end
end
