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

		def destroy_reservation id 
			reservation = repository.find(id) 
			reservation.destroy
		rescue ActiveRecord::RecordNotFound
			raise ReservationNotFound
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

		def fetch_admin offset, limit
			repository.limit(limit).offset(offset)
		end

		def fetch_all_admin
			repository.all
		end

		def update_reservation params, id
			reservation = repository.find(id.to_i)
			raise InvalidParams unless reservation.update(params)
			reservation
		rescue ActiveRecord::RecordNotFound
			raise ReservationNotFound
		end

		def seats_taken_sql_query screening_id
			sql = "SELECT * FROM RESERVATIONS 
							FULL OUTER JOIN POSITIONS 
							ON POSITIONS.RESERVATION_ID = RESERVATIONS.ID 
							WHERE SCREENING_ID = #{screening_id}"
			ActiveRecord::Base.connection.execute(sql)
		end
	end
end