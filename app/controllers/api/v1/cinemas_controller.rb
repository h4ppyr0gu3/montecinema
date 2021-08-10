# frozen_string_literal: true

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
        if cinema.save
          cols = ('a'..'z').take(params[:columns]).to_a
          rows = (1..(params[:rows])).to_a
          seats = cols.product(rows).map(&:join)
          seats.each do |seat_number|
            seat = cinema.seats.new(seat_number: seat_number)
            if seat.save
              Rails.logger.info "cinema_number: #{params[:cinema_number]}, seat_number: #{seat_number}"
            else
              Rails.logger.error seat.errors.messages
            end
          end
          render json: cinema, status: :created
        else
          render json: cinema.errors, status: :bad_request
        end
      end

      def destroy
        @cinema.destroy
        render body: nil, status: :no_content
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
