module Cinemas
	class CinemaRepository
		attr_reader :repository

		def initialize(repository: Cinemas::Model)
			@repository = repository
		end

		def find_by_id(id)
			repository.find(id)
		end

		def create_cinema params
			total_seats = params[:rows] * params[:columns]
			params[:total_seats] = total_seats
			cinema = repository.create(params)
	    Seats::SeatRepository.new.create_cinema_seats(
	    	params[:rows],
	    	params[:columns],
	    	cinema.id
			)
	    return cinema
	  end

		def destroy_cinema(cinema)
			cinema.destroy 
		end

		def cinema_seats(cinema)
			cinema.seats
		end

	end
end
