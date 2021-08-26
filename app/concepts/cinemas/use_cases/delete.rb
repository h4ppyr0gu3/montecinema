module Cinemas
  module UseCases
    class Delete
      def initialize(cinema)
        @cinema = cinema
      end

      def call
        CinemaRepository.new.destroy_cinema(cinema)
      end

      private

      attr_reader :cinema
    end
  end
end