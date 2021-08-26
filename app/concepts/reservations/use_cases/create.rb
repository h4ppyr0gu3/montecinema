module Reservations
	module UseCases
		class Create
			SeatAlreadyTaken = Class.new(StandardError)
			attr_reader :params, :user_id, :seats_taken, :cinema, :screening
			def initialize params, user_id
				@params = params
				@user_id = user_id
			end

			def call
				ensure_valid_parameters
				reservation_params = {
					cinema_id: params[:cinema_id], 
					movie_id: params[:movie_id],
					screening_id: params[:screening_id],
					user_id: user_id
				}
				reservation = Reservations::ReservationRepository.new.create_reservation(reservation_params)
				Positions::UseCases::Create.new(reservation.id, params[:seat_ids]).call
				update_available_seats
				return reservation
			end

			def ensure_valid_parameters
				@cinema = Cinemas::CinemaRepository.new.find_by_id(params[:cinema_id])
				Movies::MovieRepository.new.find_by_id(params[:movie_id])
				@screening = Screenings::ScreeningRepository.new.find_by_id(params[:screening_id])
				sql_seats_taken
				params[:seat_ids].map do |seat_ids|
					seat = Seats::SeatRepository.new.find_by_id(seat_ids[:seat_id])
					raise SeatAlreadyTaken unless seats_taken.exclude?(seat_ids[:seat_id])
				end
			end

			def sql_seats_taken
				sql = "SELECT * FROM RESERVATIONS 
							FULL OUTER JOIN POSITIONS 
							ON POSITIONS.RESERVATION_ID = RESERVATIONS.ID 
							WHERE SCREENING_ID = #{params[:screening_id]}"
				sql_result = ActiveRecord::Base.connection.execute(sql)
				@seats_taken = []
				sql_result.map { |sql| @seats_taken << sql['seat_id'] }
			end

			def update_available_seats
				Screenings::ScreeningRepository.new.update_screening(
					screening, {seats_available: cinema['total_seats'] - seats_taken.count}
				)
			end
		end
	end
end
