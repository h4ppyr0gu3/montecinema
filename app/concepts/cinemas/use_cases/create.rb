module Cinemas
  module UseCases
    class Create
      def initialize(params)
        @params = params
      end

      def call
        raise CinemaNumberAlreadyTaken unless CinemaRepository.new.
        find_by_params(cinema_number: params[:cinema_number]).nil?
        total_seats = params[:rows].to_i * params[:columns].to_i
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

      attr_reader :params, :repository
    end
  end
end