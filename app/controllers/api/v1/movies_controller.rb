# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      # before_action :ensure_admin, only: %i[create update destroy]
      before_action :set_movie, only: %i[show update destroy]

      def index
        render json: Movie.all
      end

      def create
        movie = Movie.new(movie_params)
        save_if movie
      end

      def show
        render json: @movie
      end

      def update
        if movie.update(movie_params)
          render json: { success: 'Updated successfully' }
        else
          render json: errors
        end
      end

      def destroy
        @movie.destroy
        render body: nil, status: :no_content
      end

      private

      def movie_params
        params.permit(:title, :length, :description, :director, :genre, :id)
      end

      def set_movie
        @movie = Movie.find(params[:id])
      end

      def ensure_admin
        if current_user.admin?
        else render json: { error: 'not found' }, status: :bad_request
        end
      end
    end
  end
end
