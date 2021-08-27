module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :set_reservation, only: %i[show destroy update]
      def index
        reservation = Reservations::UseCases::Index.new(params).call
        render json: Reservations::Representers::Multiple.new(reservation, current_users_model)
      end

      def show
        render json: Reservations::Representers::Single.new(@reservation, current_users_model).call
      end

      def create
        reservation = Reservations::UseCases::Create.new(reservation_deserializer, current_users_model.id).call
        render json: Reservations::Representers::Single.new(reservation, current_users_model).call
      rescue Cinemas::CinemaRepository::CinemaNotFound
        render json: {error: 'Cinema not found'}
      rescue Movies::MovieRepository::MovieNotFound
        render json: {error: 'Movie not found'}
      rescue Screenings::ScreeningRepository::ScreeningNotFound
        render json: {error: 'Screening not found'}
      rescue Seats::SeatRepository::SeatNotFound
        render json: {error: 'Seats not found'}
      rescue Reservations::UseCases::Create::SeatAlreadyTaken
        render json: {error: 'Seats Already Taken'}
      end

      def update
        if (@reservation = current_user.reservations.update(reservation_deserializer))
          render json: reservation, status: :created
        else
          render json: reservation.errors 
        end 
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
      rescue Reservations::ReservationRepository::ReservationNotFound
        render json: {error: 'reservation not found'}
      end
    end
  end
end
