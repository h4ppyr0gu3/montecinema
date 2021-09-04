module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_users_model!
      before_action :set_reservation, only: %i[show destroy]
      def index
        reservation = Reservations::UseCases::Index.new(params, current_users_model).call
        render json: Reservations::Representers::Multiple.new(reservation, current_users_model).call
      rescue Reservations::UseCases::Index::UserNotFound
        render json: { error: 'user not found' }
      end

      def show
        render json: Reservations::Representers::Single.new(@reservation, current_users_model).call
      end

      def create
        reservation = Reservations::UseCases::Create.new(reservation_deserializer, current_users_model.id).call
        render json: Reservations::Representers::Single.new(reservation, current_users_model).call
      end

      def update
        reservation = Reservations::UseCases::Update.new(reservation_deserializer, params['id'],
                                                         current_users_model.id).call
        render json: { success: 'jfjnsnv' }
      end

      def destroy
        Reservations::UseCases::Delete.new(@reservation).call
        render head: :no_content
      end

      private

      def reservation_deserializer
        {
          screening_id: params['data']['attributes']['screening_id'],
          cinema_id: params['data']['attributes']['cinema_id'],
          seat_ids: params['data']['attributes']['seat_ids'],
          movie_id: params['data']['attributes']['movie_id']
        }
      end

      def set_reservation
        @reservation = Reservations::ReservationRepository.new.find_by_id(params[:id])
      end
    end
  end
end
