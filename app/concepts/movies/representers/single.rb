module Movies
	module Representers
		class Single
			attr_reader :movie
			def initialize(movie)
				@movie = movie
			end

			def call
				{
					data:
						Movies::Representers::Data.new(movie).call
				}
			end
		end
	end
end