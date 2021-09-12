module Reservations
	module UseCases
		class Create < UseCase::Base
			SeatAlreadyTaken = Class.new(StandardError)
			attr_reader :args, :user_id, :seats_taken, :cinema, :screening

			def persist
				@user_id = self.params[:user_id]
				@args = self.params[:reservation]
				ensure_valid_parameters
				reservation_params = {
					cinema_id: args[:cinema_id], 
					movie_id: args[:movie_id],
					screening_id: args[:screening_id],
					user_id: @user_id
				}
				reservation = Reservations::ReservationRepository.new.create_reservation(reservation_params)
				Positions::UseCases::Create.new(reservation.id, args[:seat_ids]).call
				update_available_seats
				user = Users::UserRepository.new.find_by_id(user_id)
				ReservationMailer.with(user: user, reservation: reservation).reservation_created.deliver_later
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

			def update_available_seats
				Screenings::ScreeningRepository.new.update_screening(
					screening.id, {seats_available: cinema['total_seats'].to_i - (seats_taken.count).to_i}
				)
			end
		end
	end
end
