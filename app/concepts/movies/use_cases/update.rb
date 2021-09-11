module Movies
	module UseCases
		class Update < UseCase::Base
			def persist
				updated_movie = MovieRepository.new.update_movie(params[:id], params[:attributes])
			end
		end
	end
end