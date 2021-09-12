module Cinemas
  module UseCases
    class Delete < ::UseCase::Base

      def persist
        CinemaRepository.new.destroy_cinema(params[:cinema][:id])
      end
    end
  end
end