module Api
  module V1
    class MoviesController < ApplicationController
      MissingParams = Class.new(StandardError)
      before_action :set_movie, only: %i[show update destroy]

      def index
        movies = Movies::UseCases::Index.new(params).call
        render json: Movies::Representers::Multiple.new(movies).call
      end

      def create
        parse_params
        movie = Movies::UseCases::Create.new(movie_deserializer).call
        render json: Movies::Representers::Single.new(movie).call, status: :created
      rescue Api::V1::MoviesController::MissingParams
        render json: { errors: @errors }
      rescue Movies::MovieRepository::MovieAlreadyExists
        render json: { errors: 'Movie already exists' }
      end

      def show
        render json: Movies::Representers::Single.new(@movie).call
      end

      def update
        parse_params
        movie = Movies::UseCases::Update.new(@movie, movie_deserializer).call
        render json: Movies::Representers::Single.new(
          Movies::MovieRepository.new.find_by(id: params[:id])
        ).call, status: :created
      rescue Api::V1::MoviesController::MissingParams
        render json: { errors: @errors }
      end

      def destroy
        Movies::UseCases::Delete.new(@movie).call
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
        @movie = Movies::MovieRepository.new.find_by_id(params[:id])
      rescue Movies::MovieRepository::MovieNotFound
        render json: { error: 'Movie not found' }
      end

      def parse_params
        @errors = {}
        movie_deserializer.map do |k, v|
          @errors[k] = 'Missing parameter' if v.blank?
        end
        raise MissingParams if @errors.present?
      end
    end
  end
end
