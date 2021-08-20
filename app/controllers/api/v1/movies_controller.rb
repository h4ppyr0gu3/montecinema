module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[show update destroy]

      def index
        jsonapi_paginate(Movie.all) do |paginated|
          render jsonapi: paginated, status: :ok
        end
      end

      def create
        movie = Movie.new(movie_deserializer)
        if movie.save
          render jsonapi: movie, status: :created
        else
          render jsonapi_errors: movie.errors, status: :bad_request
        end
      end

      def show
        render jsonapi: @movie
      end

      def update
        if @movie.update(movie_deserializer)
          render jsonapi: @movie, status: :accepted
        else
          render jsonapi_errors: @movie.errors
        end
      end

      def destroy
        @movie.destroy
        render head: :no_content
      end

      private

      def movie_deserializer
        {
          title: params['data']['attributes']['title'],
          length: params['data']['attributes']['length'],
          description: params['data']['attributes']['description'],
          director: params['data']['attributes']['director'],
          genre: params['data']['attributes']['genre']
        }
      end

      def set_movie
        @movie = Movie.find(params[:id])
      end
    end
  end
end
