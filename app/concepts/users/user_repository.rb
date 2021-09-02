module Users
	class UserRepository
		UserNotFound = Class.new(StandardError)
		attr_reader :adapter
		def initialize adapter: Users::Model
			@adapter = adapter
		end 

		def create_user params
			adapter.create(params)
		end

		def destroy_user id 
			user = adapter.find(id)
			user.destroy
		end

		def fetch offset, limit
			adapter.limit(limit).offset(offset)
		end

		def fetch_all
			adapter.all 
		end

		def find_by_id id 
			adapter.find(id)
		rescue ActiveRecord::RecordNotFound
			raise UserNotFound
		end

		def update_user id, params
			user = adapter.find_by(id)
			user.update!(params)
		end
	end
end
