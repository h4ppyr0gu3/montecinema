module Movies
	module Representers
		class Data
			attr_reader :movie
			def initialize(movie)
				@movie = movie
			end

			def call
				serializer = 
				{
					type: 'movie',
					id: movie.id,
					attributes: {
						title: movie.title,
						description: movie.description,
						genre: movie.genre,
						director: movie.director,
						length: movie.length
					},
					relationships: {
						screenings: [
							# if cinema.screenings.present?
							# 	Screenings::Representers::MultipleRelationships.new(cinema.screenings).call
							# end
						]
					}
				}
				return serializer
			end
		end
	end
end