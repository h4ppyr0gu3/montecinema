module Movies
	module Representers
		class Single
			def initialize(movie)
				@movie = movie
			end

			def call
				serializer = 
				{
					data: {
						type: 'movie',
						id: movie.id,
						attributes: {
							title: movie.title,
							description: movie.description,
							genre: movie.genre,
							director: movie.director,
							
						}
					}
				}