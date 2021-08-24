module Cinemas
  module UseCases
    class Create
      def initialize(params)
        @repository = Cinemas::CinemaRepository.new
        @params = params
      end

      def call
        repository.create_cinema(params)
      end

      private

      attr_reader :params, :repository
    end
  end
end