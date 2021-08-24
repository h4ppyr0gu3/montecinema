module Movies
	module UseCases
		class Create
			def initialize params
				@params = params
			end

			def call
				Movies::MovieRepository.new.create_movie(params)
			end

			private

			attr_reader :params 
		end
	end
end