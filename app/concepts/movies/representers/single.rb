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
						movie.instance_eval do |movie|
							Movies::Representers::Data.new(movie).call
						end
				}
				return serializer
			end
		end
	end
end