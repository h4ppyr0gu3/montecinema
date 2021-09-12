module Cinemas
  module UseCases
    class Create < ::UseCase::Base
      CinemaNumberAlreadyTaken = Class.new(StandardError)

      def persist
        raise CinemaNumberAlreadyTaken unless CinemaRepository.new.
        find_by_params(cinema_number: params[:cinema_number]).nil?
        params[:total_seats] = total_seats
        cinema = Cinemas::CinemaRepository.new.create_cinema(params)
        Seats::UseCases::Create.new(
          params[:rows].to_i,
          params[:columns].to_i,
          cinema['id']
        ).call
        return cinema
      end

      private

      def total_seats
        params[:rows].to_i * params[:columns].to_i
      end

      attr_reader :params, :repository
    end
  end
end