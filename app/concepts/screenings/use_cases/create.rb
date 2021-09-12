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
				params[:airing_time] = DateTime.parse(params[:airing_time])
				validate_screening_time(params[:cinema_id])
				screening = Screenings::ScreeningRepository.new.create_screening(params)
				TimeoutEmailWorker.perform_at(screening.airing_time - 30.minutes, screening)
			end

			def validate_screening_time cinema_id
				screenings = ScreeningRepository.new.where(cinema_id: cinema_id, 'airing_time >': params[:airing_time] - 1.day )
				screenings.map do |screening|
					if screening.airing_time > params[:airing_time]
						raise InvalidScreeningTime unless 
						(params[:airing_time] + Movies::Model.find_by_id(params[:movie_id]).length.minutes) <
						screening.airing_time
					else
						raise InvalidScreeningTime unless params[:airing_time] > 
						screening.airing_time + screening.movie.length.minutes
					end
				end
			end
		end
	end
end