module Movies
	class MovieRepository
		attr_reader :repository

		def initialize(repository: Movies::Model)
			@repository = repository
		end

		def create_movie(params)
			repository.create(params)
		end

	end
end
