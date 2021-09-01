module Screenings
	module Representers
		class Single
			def initialize screening
				@screening = screening 
			end

			def call
				serializer =
				{
					data: Screenings::Representers::Data.new(screening).call
				}
				return serializer
			end

			private

			attr_reader :screening
		end
	end
end
