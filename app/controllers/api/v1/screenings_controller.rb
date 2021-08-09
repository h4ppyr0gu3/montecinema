class Api::V1::ScreeningsController < ApplicationController
	before_action :set_screening, only: %i[show update destroy]

	def index
		render json: Screening.all
	end

	def show
		render json: screening
	end

	def create
		screening = Screening.new(screening_params)
		save_if(screening, "Created")
	end

	def update
		if screening.update(screening_params)
      render json: {success: "Updated successfully"}
    else
      render json: screening.errors
    end
	end

	def destroy
		screening.delete
		render json: {success: "Deleted successfully"}
	end

	private

	def set_screening
		screening = Screening.find(params[:id])
	end

	def screening_params
		params.permit(:movie_id, :airing_time, :cinema_number, :additional_cost)
	end

end