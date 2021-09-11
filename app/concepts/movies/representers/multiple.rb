module Movies
	module Representers
		class Multiple
			attr_reader :movies
			def initialize(movies)
				@movies = movies
			end

			def call
				{
					data: 
						movies.map do |movie|
							Movies::Representers::Data.new(movie).call
						end,
					meta: {
						total_count: Movies::MovieRepository.new.number_of_movies
					}
				}
			end
		end
	end
end
