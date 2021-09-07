module Cinemas
  module UseCases
    class Delete < ::UseCase::Base

      def persist
        CinemaRepository.new.destroy_cinema(params[:cinema_id])
      end
    end
  end
end