module Screenings
	module UseCases
		class Index
			attr_reader :params
			def initialize params
				@params = params
			end

			def call
				params.present? ? ScreeningRepository.new.fetch(
					params[:offset], params[:limit]
					) : ScreeningRepository.new.fetch_all
			end
		end
	end
end
