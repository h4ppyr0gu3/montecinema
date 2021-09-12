module Api
  module V1
    class CinemasController < ApplicationController
      before_action :set_cinema, only: %i[show destroy]
      around_action :skip_bullet, only: %i[destroy]
      before_action :authenticate_users_model!

      def show
        authorize([:api, :v1, @cinema])
        render json: ::Cinemas::Representers::Single.new(
          cinema: @cinema,
          screenings: @cinema.screenings,
          seats: @cinema.seats
        ).call, status: :ok
      end

      def create
        authorize([:api, :v1, ::Cinemas::Model])
        cinema = ::Cinemas::UseCases::Create.new(params: cinema_deserializer).call
        render json: ::Cinemas::Representers::Single.new(
          cinema: cinema,
          screenings: cinema.screenings,
          seats: cinema.seats
        ).call, status: :created
      end

      def destroy
        authorize([:api, :v1, @cinema])
        ::Cinemas::UseCases::Delete.new(params: { cinema: @cinema }).call
        render head: :no_content, status: :ok
      end

      private

      def set_cinema
        @cinema = ::Cinemas::CinemaRepository.new.find_by_id(params[:id])
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
