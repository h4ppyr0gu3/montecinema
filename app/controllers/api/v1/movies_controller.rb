module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[show update destroy]

      def index
        render json: Movie.all
      end

      def create
        movie = Movie.new(movie_params)
        if movie.save
          render json: movie, status: :created
        else
          render json: movie.errors, status: :bad_request
        end
      end

      def show
        render json: @movie
      end

      def update
        if @movie.update(movie_params)
          render json: @movie, status: :accepted
        else
          render json: @movie.errors
        end
      end

      def destroy
        @movie.destroy
        render body: nil, status: :no_content
      end

      private

      def movie_params
        params.permit(:title, :length_mins, :description, :director, :genre)
      end

      def set_movie
        @movie = Movie.find(params[:id])
      end
    end
  end
end
