module Reservations
	module UseCases
		class Update < UseCase::Base
			attr_reader :args, :id, :seats_taken, :user_id
			def persist
				@args = self.params[:args]
				@id = self.params[:id]
				@user_id = self.params[:user_id]
				ensure_valid_parameters
				reservation_params = {
					cinema_id: args[:cinema_id], 
					movie_id: args[:movie_id],
					screening_id: args[:screening_id],
					user_id: user_id
				}
				reservation = ReservationRepository.new.update_reservation(reservation_params, id)
				Positions::PositionRepository.new.delete_reservation_positions(reservation.id)
				Positions::UseCases::Create.new(reservation.id, args[:seat_ids]).call
				return reservation
			end

			private

			def ensure_valid_parameters
				@cinema = Cinemas::CinemaRepository.new.find_by_id(args[:cinema_id])
				Movies::MovieRepository.new.find_by_id(args[:movie_id])
				@screening = Screenings::ScreeningRepository.new.find_by_id(args[:screening_id])
				sql_seats_taken
				args[:seat_ids].map do |seat_ids|
					seat = Seats::SeatRepository.new.find_by_id(seat_ids[:seat_id])
					raise SeatAlreadyTaken unless seats_taken.exclude?(seat_ids[:seat_id])
				end
			end

			def sql_seats_taken
				sql_result = Reservations::ReservationRepository.new.seats_taken_sql_query(args[:screening_id])
				@seats_taken = []
				sql_result.map { |sql| @seats_taken << sql['seat_id'] }
			end
		end
	end
end
