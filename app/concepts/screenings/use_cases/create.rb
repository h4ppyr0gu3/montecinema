module Screenings
	module UseCases
		class Create
			InvalidScreeningTime = Class.new(StandardError)
			attr_reader :params
			def initialize params
				@params = params
			end

			def call
				availability = ScreeningRepository.new.next_available_time(params[:cinema_id])
				params[:airing_time] = DateTime.parse(params[:airing_time]).change(:offset => "+0200")

				availability.map do |value|
					raise InvalidScreeningTime unless params[:airing_time] > value
				end
				Screenings::ScreeningRepository.new.create_screening(params)
			end
		end
	end
end