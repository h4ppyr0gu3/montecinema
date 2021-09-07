module Api
  module V1
    class MoviesController < ApplicationController
      MissingParams = Class.new(StandardError)
      around_action :skip_bullet, only: %i[index]
      before_action :set_movie, only: %i[show update destroy]

      def index
        movies = Movies::UseCases::Index.new(params).call
        render json: Movies::Representers::Multiple.new(movies).call
      end

      def create
        authorize([:api, :v1, Movies::Model])
        parse_params
        movie = Movies::UseCases::Create.new(params: movie_deserializer).call
        render json: Movies::Representers::Single.new(movie).call, status: :created
      end

      def show
        authorize([:api, :v1, @movie])
        render json: Movies::Representers::Single.new(@movie).call
      end

      def update
        authorize([:api, :v1, @movie])
        parse_params
        Movies::UseCases::Update.new(@movie, movie_deserializer).call
        render json: Movies::Representers::Single.new(
          Movies::MovieRepository.new.find_by(id: params[:id])
        ).call, status: :created
      end

      def destroy
        authorize([:api, :v1, @movie])
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
