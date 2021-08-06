class MoviesController < ApplicationController

	before_action :ensure_admin, only: %i[create update destroy]

	def index
	end

	def create
		movie = Movie.new(movie_params)
		if movie.save
			render json: {success: 'Created successfully'}, status: :ok
		else 
			render json: movie.errors
		end
	end

	def show
	end

	def update
		movie = Movie.find(params[:id]).update(movie_params)
		if movie.save
			render json: {success: 'updated successfully'}, status: :ok
		else 
			render json: movie.errors
		end
	end

	def destroy
		Movie.find(params[:id]).delete
	end

	private

	def movie_params
		params.require(:title).permit(:length, :description, :director, :genre)
	end

	def ensure_admin
		if current_user.admin?
		else render json: {}, status: :bad_request
		end
	end

end