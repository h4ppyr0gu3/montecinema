class Api::V1::CinemasController < ApplicationController

	before_action :set_cinema, only: %i[show destroy]

	def index
		render json: Cinema.all
	end

	def show
		render json: cinema
	end

	def create
		cinema = Cinema.new(params[:cinema_number])
    if cinema.save 
      cols = ("a".."z").take(params[:columns]).to_a
	    rows = (1..(params[:rows])).to_a
	    seats = cols.product(rows).map(&:join)
	    seats.each do |seat_number|
	      seat = cinema.seats.new(seat_number: seat_number)
	      if seat.save
	        Rails.logger.info "cinema_number: #{cinema_number}, seat_number: #{seat_number}"
	      else
	        Rails.logger.error seat.errors.messages
	      end
	    end
	    render json: {success: "Created successfully"}
    else
      render json: cinema.errors
    end
	end

	def destroy
		cinema.delete
		render json: {success: "Deleted successfully"}
	end

	private

	def set_cinema
		cinema = Cinema.find(params[:id])
	end

	def cinema_params
		params.permit(:rows, :columns, :cinema_number)
	end
end