module Movies
	module UseCases
		class Index < UseCase::Base

			def persist
				params.present? ? MovieRepository.new.fetch(
					params[:offset], params[:limit]
					) : MovieRepository.new.fetch_all
			end
		end
	end
end
