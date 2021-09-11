module Movies
	module Representers
		class Data
			attr_reader :movie
			def initialize(movie)
				@movie = movie
			end

			def call
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
						screenings: 
							if movie.screenings.present?
								Screenings::Representers::MultipleRelationships.new(movie.screenings).call
							end
					}
				}
			end
		end
	end
end