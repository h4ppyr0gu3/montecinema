module Api
  module V1
    class CinemasController < ApplicationController
      before_action :set_cinema, only: %i[show destroy update]
      around_action :skip_bullet, only: %i[destroy]

      def show
        render json: Cinemas::Representers::Single.new(@cinema).call, status: :ok
      end

      def create
        puts params
        cinema = Cinemas::UseCases::Create.new(cinema_deserializer).call
        render json: Cinemas::Representers::Single.new(cinema).call, status: :created
      rescue Cinemas::CinemaRepository::CinemaNumberAlreadyTaken
        render json: {error: 'Cinema number already taken'}
      end

      def update
        cinema = Cinemas::UseCases::Update.new(cinema_deserializer, @cinema).call
        render json: Cinemas::Representers::Single.new(cinema).call, status: :created
      end

      def destroy
        Cinemas::UseCases::Delete.new(@cinema).call
        render head: :no_content
      end

      private

      def set_cinema
        @cinema = Cinemas::CinemaRepository.new.find_by_id(params[:id])
      rescue Cinemas::CinemaRepository::CinemaNotFound
        render json: {error: 'Cinema Not Found'}, status: :not_found
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
