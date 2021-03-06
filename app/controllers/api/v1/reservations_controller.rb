module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_users_model!
      before_action :set_reservation, only: %i[show destroy update]

      def index
        reservation = ::Reservations::UseCases::Index.new(params: {
                                                            query: params,
                                                            user: current_users_model
                                                          }).call
        render json: ::Reservations::Representers::Multiple.new(reservation, current_users_model).call
      rescue ::Reservations::UseCases::Index::UserNotFound
        render json: { error: 'user not found' }
      end

      def show
        authorize([:api, :v1, @reservation])
        render json: ::Reservations::Representers::Single.new(@reservation, current_users_model).call
      end

      def create
        reservation = ::Reservations::Model.new
        authorize([:api, :v1, reservation])
        reservation = ::Reservations::UseCases::Create.new(params: {
                                                             reservation: reservation_deserializer,
                                                             user_id: current_users_model.id
                                                           }).call
        render json: ::Reservations::Representers::Single.new(reservation, current_users_model).call, status: :created
      end

      def update
        authorize([:api, :v1, @reservation])
        ::Reservations::UseCases::Update.new(params: {
                                               args: reservation_deserializer,
                                               id: params['id'],
                                               user_id: current_users_model.id
                                             }).call
        reservation = ::Reservations::ReservationRepository.new.find_by_id(params['id'])
        render json: ::Reservations::Representers::Single.new(reservation, current_users_model).call
      end

      def destroy
        authorize([:api, :v1, @reservation])
        ::Reservations::UseCases::Delete.new(params: { reservation: @reservation }).call
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
        @reservation = ::Reservations::ReservationRepository.new.find_by_id(params[:id])
      end
    end
  end
end
