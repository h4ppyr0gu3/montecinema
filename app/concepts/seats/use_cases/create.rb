module Seats
	module UseCases
		class Create
			attr_reader :rows_int, :columns, :id 
			def initialize rows_int, columns, id 
				@rows_int = rows_int
				@columns = columns
				@id = id 
			end

			def call
				cols = ('a'..'z').take(columns).to_a
		    rows = (1..(rows_int)).to_a
		    seats = cols.product(rows).map(&:join)
		    seats.each do |seat_number|
		    	params = {
		    		seat_number: seat_number, 
		      	cinema_id: id, 
		      	name: seat_number.to_s + id.to_s
		    	}
		      Seats::SeatRepository.new.create_seats(params)
		    end
		  end
		end
	end
end