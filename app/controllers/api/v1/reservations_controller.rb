module Api
  module V1
    class ReservationsController < ApplicationController

      before_action :set_reservation, only: %i[show destroy update]
      def index
        render json: current_user.reservations.all, status: :ok
      end

      def show
        render json: @reservation
      end

      def create
        if (reservation = current_user.reservations.create(reservation_params))
          render json: reservation, status: :created
        else
          render json: reservation.errors
        end
      end

      def update
        if (@reservation = current_user.reservations.update(reservation_params))
          render json: reservation, status: :created
        else
          render json: reservation.errors
        end
      end

      def destroy 
        @reservation.delete 
        render head: :no_content
      end

      private

      def reservation_params
        params.require(:reservation).permit(
          :screening_id,
          :cinema_id,
          positions_attributes: [
            :seat_id
          ]
        )
      end

      def set_reservation
        @reservation = Reservation.find(params[:id])
      end
    end
  end
end

# Joins to return info:
#	- seat = Seat.joins("INNER JOIN reservations ON reservations.seat_id = seats.id")
# => #<ActiveRecord::Relation [#<Seat id: 100, seat_number: "j10", cinema_id: 11, seat_price: "0", name: "11j10", created_at: "2021-08-13 10:03:28.269126000 +0000", updated_at: "2021-08-13 10:03:28.269...
