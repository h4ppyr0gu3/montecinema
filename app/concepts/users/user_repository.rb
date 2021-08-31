module Users
	class UserRepository
		UserNotFound = Class.new(StandardError)
		attr_reader :repository
		def initialize 
			@repository = Users::Model
		end 

		def create_user params
			repository.create(params)
		end

		def destroy_user id 
			user = repository.find(id)
			user.destroy
		end

		def fetch offset, limit
			repository.limit(limit).offset(offset)
		end

		def fetch_all
			repository.all 
		end

		def find_by_id id 
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise UserNotFound
		end

		def update_user
			
		end

	end
end
