# frozen_string_literal: true

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
        screening = Screening.new(
          movie_id: params[:movie_id],
          airing_time: params[:airing_time],
          cinema_id: Cinema.find_by(cinema_number: params[:cinema_number]).id,
          additional_cost: params[:additional_cost]
        )
        save_if screening
      end

      def update
        if screening.update(screening_params)
          render json: { success: 'Updated successfully' }
        else
          render json: screening.errors
        end
      end

      def destroy
        @screening.delete
        render body: nil, status: :no_content
      end

      private

      def set_screening
        @screening = Screening.find(params[:id])
      end

      def screening_params
        params.permit(:movie_id, :airing_time, :cinema_number, :additional_cost)
      end
    end
  end
end
