module Screenings
	module Representers
		class MultipleRelationships
			def initialize screenings
				@screenings = screenings
			end

			def call
				serializer = 
				screenings.map do |screening|
					Screenings::Representers::Relationship.new(screening).call
				end
				return serializer
			end

			private

			attr_reader :screenings
		end
	end
end
