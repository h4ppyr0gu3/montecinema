module Reservations
	class ReservationRepository
    ReservationNotFound = Class.new(StandardError)
    InvalidParams = Class.new(StandardError)
		attr_reader :repository 
		def initialize
			@repository = Reservations::Model
		end

		def create_reservation params
			repository.create!(params)
		end

		def destroy_reservation reservation 
			reservation.destroy
		end

		def find_by_id id 
			repository.find(id)
		rescue ActiveRecord::RecordNotFound
			raise ReservationNotFound
		end

		def fetch offset, limit, user
			repository.where(user_id: user.id).limit(limit).offset(offset)
		end

		def fetch_all user
			repository.where(user_id: user.id) 
		end

		def update_reservation params, id
			reservation = repository.find(id.to_i)
			raise InvalidParams unless reservation.update!(params)
			reservation
		rescue ActiveRecord::RecordNotFound
			raise ReservationNotFound
		end
	end
end