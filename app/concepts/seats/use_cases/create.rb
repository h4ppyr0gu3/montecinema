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
				seats = create_seat_numbers
		    seats.map do |seat_number|
		    	params = {
		    		seat_number: seat_number, 
		      	cinema_id: id, 
		      	name: "#{seat_number} - #{id}"
		    	}
		      Seats::SeatRepository.new.create_seats(params)
		    end
		  end

		  private 

		  def create_seat_numbers
		  	cols = ('a'..'z').take(columns).to_a
		    rows = (1..(rows_int)).to_a
		    cols.product(rows).map(&:join)
		  end
		end
	end
end