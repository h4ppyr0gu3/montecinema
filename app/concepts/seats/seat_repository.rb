module Seats
	class SeatRepository
		SeatNotFound = Class.new(StandardError)
		attr_reader :repository

		def initialize(repository: Seats::Model)
			@repository = repository
		end

		def create_cinema_seats rows, columns, id
			cols = ('a'..'z').take(columns).to_a
	    rows = (1..(rows)).to_a
	    seats = cols.product(rows).map(&:join)
	    seats.each do |seat_number|
	      seat = Seats::Model.create(
	      	seat_number: seat_number, 
	      	cinema_id: id, 
	      	name: seat_number.to_s + id.to_s
	      )
	    end
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
