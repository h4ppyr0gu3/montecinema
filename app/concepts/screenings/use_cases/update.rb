module Screenings
	module UseCases
		class Update
			attr_reader :screening, :params
			def initialize screening, params
				@screening = screening
				@params = params
			end

			def call
				ScreeningRepository.new.update_screening(screening, params)
			end
		end
	end
end