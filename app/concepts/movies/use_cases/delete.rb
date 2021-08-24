module Movies
	module UseCases
		class Delete
			attr_reader :movie
			def initialize movie 
				@movie = movie 
			end 

			def call
				MovieRepository.new.destroy_movie(movie)
			end
		end
	end
end

