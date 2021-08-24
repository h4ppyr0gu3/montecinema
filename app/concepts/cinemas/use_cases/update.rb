module Cinemas
  module UseCases
    class Update
      CinemaNumberDoesntExist = Class.new(StandardError)
      def initialize(params, cinema)
        @params = params
        @cinema = cinema
      end

      def call
        ActiveRecord::Base.transaction do 
          Cinemas::UseCases::Delete.new(cinema).call
          cinema = Cinemas::UseCases::Create.new(params).call
        end
        return cinema
      end

      private

      attr_reader :params, :cinema
    end
  end
end