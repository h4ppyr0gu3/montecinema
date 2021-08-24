module Movies
	module UseCases
		class Index
			attr_reader :params
			def initialize params
				@params = params
			end

			def call
				params.present? ? MovieRepository.new.fetch(
					params[:offset], params[:limit]
					) : MovieRepository.new.fetch_all
			end
		end
	end
end
