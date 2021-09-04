module Movies
	module UseCases
		class Create < ::UseCase::Base
			def persist
				Movies::MovieRepository.new.create_movie(params)
			end
		end
	end
end