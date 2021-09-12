module Api
  module V1
    class CinemasController < ApplicationController
      before_action :set_cinema, only: %i[show destroy]
      around_action :skip_bullet, only: %i[destroy]

      def show
        render json: Cinemas::Representers::Single.new(@cinema).call, status: :ok
      end

      def create
        cinema = Cinemas::UseCases::Create.new(cinema_deserializer).call
        render json: Cinemas::Representers::Single.new(cinema).call, status: :created
      end

      def destroy
        Cinemas::UseCases::Delete.new(@cinema).call
        render head: :no_content
      end

      private

      def set_cinema
        @cinema = Cinemas::CinemaRepository.new.find_by_id(params[:id])
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
