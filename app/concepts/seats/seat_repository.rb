module Seats
	class SeatRepository
		SeatNotFound = Class.new(StandardError)
		attr_reader :repository

		def initialize(repository: Seats::Model)
			@repository = repository
		end

		def create_seats params
			repository.create!(params)
		end

		def fetch_cinema_seats id 
			Seats::Model.where(cinema_id: id)
		end

		def find_by_id id 
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise SeatNotFound
		end
	end
end
