module Api
  module V1
    class CinemasController < ApplicationController
      before_action :set_cinema, only: %i[show destroy]

      def index
        jsonapi_paginate(Cinema.all) do |paginated|
          render jsonapi: paginated, status: :ok
        end
      end

      def show
        render jsonapi: @cinema, status: :ok
      end

      def create
        cinema = Cinema.new(cinema_number: cinema_deserializer[:cinema_number])
        begin
          ActiveRecord::Base.transaction do
            generate_seats(cinema_deserializer, cinema) if cinema.save!
          end
        rescue ActiveRecord::RecordInvalid => e
          render jsonapi_errors: e.messages, status: :bad_request
        end
        render jsonapi: cinema
      end


      def destroy
        @cinema.destroy
        render head: :no_content
      end

      private

      def set_cinema
        @cinema = Cinema.find(params[:id])
      end

      def generate_seats(params, cinema)
        cols = ('a'..'z').take(params[:columns]).to_a
        rows = (1..(params[:rows])).to_a
        seats = cols.product(rows).map(&:join)
        seats.each do |seat_number|
          seat = cinema.seats.new(seat_number: seat_number)
          Rails.logger.error seat.errors.messages unless seat.save!
        end
      end

      def cinema_deserializer
        {
          rows: params['data']['attributes']['rows'],
          columns: params['data']['attributes']['columns'],
          cinema_number: params['data']['attributes']['cinema_number']
        }
      end

      # def jsonapi_page_size(pagination_params)
      #   per_page = pagination_params[:size].to_f.to_i
      #   per_page = 30 if per_page > 30 || per_page < 1
      #   per_page
      # end
    end
  end
end
