module Screenings
	module UseCases
		class Delete
			attr_reader :screening
			def initialize screening
				@screening = screening
			end

			def call 
				ScreeningRepository.new.destroy_screening(screening)
			end
		end
	end
end