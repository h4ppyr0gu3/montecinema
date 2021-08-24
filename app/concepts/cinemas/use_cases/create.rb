module Cinemas
  module UseCases
    class Create
    CinemaNumberAlreadyTaken = Class.new(StandardError)
      def initialize(params)
        @repository = Cinemas::CinemaRepository.new
        @params = params
      end

      def call
      raise CinemaNumberAlreadyTaken unless repository.find_by_params(cinema_number: params[:cinema_number]).nil?
        repository.create_cinema(params)
      end

      private

      attr_reader :params, :repository
    end
  end
end