module Screenings
	module Representers
		class Data
			attr_reader :screening
			def initialize screening
				@screening = screening
			end

			def call
				serializer = 
				{
					id: screening.id,
					type: 'screening',
					attributes: {
						airing_time: screening.airing_time,
						additional_cost: screening.additional_cost,
						seats_available: screening.seats_available,
					},
					relationships: {
						movie: Movies::Representers::Relationship.new(Movies::Model.find_by_id(screening.movie_id)).call,
						cinema: Cinemas::Representers::Relationship.new(Cinemas::Model.find_by_id(screening.cinema_id)).call
					}
				}
				return serializer
			end
		end
	end
end
