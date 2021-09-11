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
						).call,
						movie: Movies::Representers::Relationship.new(
							reservation.movie
						).call,
						screening: Screenings::Representers::Relationship.new(
							reservation.screening
						).call,
						cinema: ::Cinemas::Representers::Relationship.new(
							cinema: reservation.cinema
						).call,
						seats: Seats::Representers::MultipleRelationships.new(
							reservation.seats
						).call
					}
				}
			end
		end
	end
end