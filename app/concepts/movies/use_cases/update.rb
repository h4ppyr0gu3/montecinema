module Movies
	module UseCases
		class Update
			attr_reader :params, :movie
			def initialize movie, params
				@params = params
				@movie = movie
			end

			def call
				updated_movie = MovieRepository.new.update_movie(movie, params)
			end
		end
	end
end