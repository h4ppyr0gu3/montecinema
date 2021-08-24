module Movies
	class MovieRepository
		MovieAlreadyExists = Class.new(StandardError)
		MovieNotFound = Class.new(StandardError)
		attr_reader :repository

		def initialize(repository: Movies::Model)
			@repository = repository
		end

		def create_movie(params)
			raise MovieAlreadyExists unless repository.find_by(
				title: params[:title]).nil?
			repository.create(params)
		end

		def find_by_id id 
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise MovieNotFound
		end

		def destroy_movie movie 
			movie.destroy
		end

		def fetch offset, limit
			repository.limit(limit).offset(offset)
		end

		def fetch_all
			repository.all 
		end

		def number_of_movies
			repository.all.count 
		end

		def update_movie movie, params
			movie.update!(params)
		end
	end
end
