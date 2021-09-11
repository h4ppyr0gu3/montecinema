module Movies
	module UseCases
		class Delete < UseCase::Base
			def persist
				MovieRepository.new.destroy_movie(params[:id])
			end
		end
	end
end

