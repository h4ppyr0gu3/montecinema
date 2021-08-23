module Cinemas
  module UseCases
    class Delete
      def initialize(cinema)
        @cinema = cinema
      end

      def call
        cinema.destroy
      end

      private

      attr_reader :cinema
    end
  end
end