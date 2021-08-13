module Api
  module V1
    class ScreeningsController < ApplicationController
      before_action :set_screening, only: %i[show update destroy]

      def index
        render json: Screening.all
      end

      def show
        render json: @screening
      end

      def create
        screening = Screening.new(screening_params)
        if screening.save
          render json: screening, status: :created
        else
          render json: screening.errors, status: :bad_request
        end
      end

      def update
        if @screening.update(screening_params)
          render json: @screening, status: :accepted
        else
          render json: @screening.errors
        end
      end

      def destroy
        @screening.delete
        render head: :no_content
      end

      private

      def set_screening
        @screening = Screening.find(screening_params[:id])
      end

      def screening_params
        params.require(:screening).permit(:id, :movie_id, :airing_time, :cinema_id, :additional_cost)
      end
    end
  end
end
