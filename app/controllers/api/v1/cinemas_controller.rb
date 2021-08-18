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
        cinema = Cinema.new(cinema_deserializer)
        if cinema.save
          render jsonapi: cinema, status: :created
        else
          render jsonapi_errors: cinema.errors, status: :bad_request
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

      def cinema_deserializer
        {
          rows: params['data']['attributes']['rows'],
          columns: params['data']['attributes']['columns'],
          cinema_number: params['data']['attributes']['cinema_number']
        }
      end
    end
  end
end
