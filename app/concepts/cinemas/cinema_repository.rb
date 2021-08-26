module Cinemas
	class CinemaRepository
		CinemaNotFound = Class.new(StandardError)
    CinemaNumberAlreadyTaken = Class.new(StandardError)
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
      repository.create!(params)
	  end

		def destroy_cinema(cinema)
			cinema.destroy 
		end

		def cinema_seats(cinema)
			repository.seats
		end

		def find_by_params(params)
			repository.find_by(params)
		end

	end
end
