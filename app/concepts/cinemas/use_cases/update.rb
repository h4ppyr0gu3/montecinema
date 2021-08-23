module Cinemas
  module UseCases
    class Update
      def initialize(params, cinema)
        @params = params
        @cinema = cinema
      end

      def call
        begin
          ActiveRecord::Base.transaction do 
            Cinemas::UseCases::Delete.new(cinema).call
            cinema = Cinemas::UseCases::Create.new(params).call
          end
          return cinema
        rescue ActiveRecord::RecordInvalid => e
          return e
        end
      end

      private

      attr_reader :params, :cinema
    end
  end
end