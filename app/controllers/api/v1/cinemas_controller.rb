module Api
  module V1
    class CinemasController < ApplicationController
      before_action :set_cinema, only: %i[show destroy]

      def index
        render json: Cinema.all, status: :ok
      end

      def show
        render json: @cinema, status: :ok
      end

      def create
        cinema = Cinema.new(cinema_number: params[:cinema_number])
        begin
          ActiveRecord::Base.transaction do
            if cinema.save!
              cols = ('a'..'z').take(params[:columns]).to_a
              rows = (1..(params[:rows])).to_a
              seats = cols.product(rows).map(&:join)
              seats.each do |seat_number|
                seat = cinema.seats.new(seat_number: seat_number)
                Rails.logger.error seat.errors.messages unless seat.save!
              end
            end
          end
          render json: cinema, status: :created
        rescue ActiveRecord::RecordInvalid => e
          render json: e.messages, status: :bad_request
        end
      end

      def destroy
        @cinema.destroy
        render head: :no_content
      end

      private

      def set_cinema
        @cinema = Cinema.find(params[:id])
      end

      def cinema_params
        params.permit(:rows, :columns, :cinema_number)
      end
    end
  end
end
