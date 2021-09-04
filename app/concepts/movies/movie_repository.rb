module Movies
	class MovieRepository
		MovieAlreadyExists = Class.new(StandardError)
		MovieNotFound = Class.new(StandardError)
		attr_reader :adapter

		def initialize adapter: Movies::Model
			@adapter = adapter
		end

		def create_movie params
			raise MovieAlreadyExists unless adapter.find_by(
				title: params[:title]).nil?
			adapter.create(params)
		end

		def find_by_id id 
			adapter.find(id)
		end

		def destroy_movie id 
			movie = adapter.find(id) 
			movie.destroy
		end

		def fetch offset, limit
			adapter.limit(limit).offset(offset)
		end

		def fetch_all
			adapter.all 
		end

		def number_of_movies
			adapter.all.count 
		end

		def update_movie id, params
			movie = adapter.find(id) 
			movie.update!(params)
		end
	end
end
