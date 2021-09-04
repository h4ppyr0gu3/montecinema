module Api
  module V1
    class ScreeningsController < ApplicationController
      before_action :set_screening, only: %i[show update destroy]

      def index
        screenings = Screenings::UseCases::Index.new(params).call
        render json: Screenings::Representers::Multiple.new(screenings).call
      end

      def show
        render json: Screenings::Representers::Single.new(@screening).call
      end

      def create
        screening = Screenings::UseCases::Create.new(screening_deserializer).call
        render json: Screenings::Representers::Single.new(screening).call
      end

      def update
        Screenings::UseCases::Update.new(@screening, screening_deserializer).call
        render json: Screenings::Representers::Single.new(set_screening).call
      end

      def destroy
        Screenings::UseCases::Delete.new(@screening).call
        render head: :no_content
      end

      private

      def set_screening
        @screening = Screenings::ScreeningRepository.new.find_by_id(params[:id])
      end

      def screening_deserializer
        {
          movie_id: params['data']['attributes']['movie_id'],
          airing_time: params['data']['attributes']['airing_time'],
          additional_cost: params['data']['attributes']['additional_cost'],
          cinema_id: params['data']['attributes']['cinema_id']
        }
      end
    end
  end
end
