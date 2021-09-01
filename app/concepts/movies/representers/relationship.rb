module Movies
	module Representers
		class Relationship
			attr_reader :movie
			def initialize movie
				@movie = movie
			end

			def call
				serialize = 
				{
					id: movie.id,
					type: 'movie',
					attributes: {
						title: movie.title,
						description: movie.description,
						director: movie.director,
						genre: movie.genre,
						length: movie.length
					}
				}
			end
		end
	end
end