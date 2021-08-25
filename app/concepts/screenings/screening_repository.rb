module Screenings
	class ScreeningRepository
		ScreeningNotFound = Class.new(StandardError)
		attr_reader :repository
		def initialize
			@repository = Screenings::Model
		end

		def create_screening(params)
			repository.create(params)
		end

		def destroy_screening(screening)
			screening.destroy 
		end

		def find_by_id id
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise ScreeningNotFound
		end

		def next_available_time cinema_id
			repository.where(cinema_id: cinema_id).pluck(:airing_time)
		end

		def update_screening(screening, params)
			screening.update!(params)
		end

		def fetch_all
			repository.all
		end

		def fetch offset, limit
			repository.limit(limit).offset(offset)
		end

		def number_of_screenings
			repository.count 
		end

		def destroy_screening screening
			screening.destroy
		end
	end
end