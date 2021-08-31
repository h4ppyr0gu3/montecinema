module Movies
	module Representers
		class Single
			attr_reader :movie
			def initialize(movie)
				@movie = movie
			end

			def call
				serializer = 
				{
					data:
						Movies::Representers::Data.new(movie).call
				}
				return serializer
			end
		end
	end
end