module Reservations
	module Representers
		class Single
			attr_reader :reservation, :user, :movie
			def initialize reservation, user
				@reservation = reservation
				@user = user 
				@movie = movie
			end

			def call 
				{
					data: {
						type: 'reservation',
						attributes: {},
						relationships: {
							user: Users::Representers::Relationship.new(
								user
							),
							movie: Movies::Representers::Relationship.new(
								reservation.movie
							),
							screening: Screenings::Representers::Relationship.new(
								reservation.screening
							),
							cinema: Cinemas::Representers::Relationship.new(
								reservation.cinema
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
