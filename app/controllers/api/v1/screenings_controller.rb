module Api
  module V1
    class ScreeningsController < ApplicationController
      before_action :set_screening, only: %i[show update destroy]

      def index
        jsonapi_paginate(Screening.all) do |paginated|
          render jsonapi: paginated, status: :ok
        end
      end

      def show
        render jsonapi: @screening
      end

      def create
        screening = Screening.new(screening_deserializer)
        if screening.save
          render jsonapi: screening, status: :created
        else
          render jsonapi_errors: screening.errors, status: :bad_request
        end
      end

      def update
        if @screening.update(screening_deserializer)
          render jsonapi: @screening, status: :accepted
        else
          render jsonapi_errors: @screening.errors
        end
      end

      def destroy
        @screening.delete
        render head: :no_content
      end

      private

      def set_screening
        @screening = Screening.find(params[:id])
      end

      def screening_deserializer
        {
          movie_id: params['data']['attributes']['movie_id'],
          airing_time: params['data']['attributes']['airing_time'],
          additional_cost: params['data']['attributes']['additional_cost'],
          cinema_id: params['data']['attributes']['cinema_id']
        }
      end
    end
  end
end
