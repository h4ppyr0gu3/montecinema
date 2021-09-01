module Reservations
	module Representers
		class Data
			attr_reader :user, :reservation
			def initialize reservation, user
				@reservation = reservation
				@user = user 
			end

			def call
				{
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
			end
		end
	end
end