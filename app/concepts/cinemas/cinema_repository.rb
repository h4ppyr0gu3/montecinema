module Cinemas
	class CinemaRepository
		CinemaNotFound = Class.new(StandardError)
		attr_reader :repository

		def initialize(repository: Cinemas::Model)
			@repository = repository
		end

		def find_by_id(id)
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise CinemaNotFound
		end

		def create_cinema params
			total_seats = params[:rows] * params[:columns]
			params[:total_seats] = total_seats
			cinema = repository.create!(params)
	    Seats::SeatRepository.new.create_cinema_seats(
	    	params[:rows],
	    	params[:columns],
	    	cinema.id
			)
	    return cinema
	  end

		def destroy_cinema(cinema)
			repository.destroy 
		end

		def cinema_seats(cinema)
			repository.seats
		end

		def find_by_params(params)
			repository.find_by(params)
		end

	end
end
