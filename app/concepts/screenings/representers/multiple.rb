module Screenings
	module Representers
		class Multiple
			attr_reader :screenings
			def initialize screenings
				@screenings = screenings
			end

			def call
				serializer = 
				{
					data: 
					screenings.map do |screening|
						Screenings::Representers::Data.new(screening).call
					end,
					meta: {
						total_count: Screenings::ScreeningRepository.new.number_of_screenings
					}
				}
			end
		end
	end
end