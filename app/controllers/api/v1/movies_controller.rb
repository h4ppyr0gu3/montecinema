class MoviesController < ApplicationController

	before_action :ensure_admin, only: %i[create update destroy]

	def index
	end

	def create
		movie = Movie.new(movie_params)
	end

	def show
	end

	def update
	end

	def destroy
	end

	private

	def ensure_admin
		if current_user.admin?
		else render json: {}, status: :bad_request
		end
	end

end