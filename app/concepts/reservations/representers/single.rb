module Reservations
	module Representers
		class Single
			attr_reader :reservation, :user
			def initialize reservation, user
				@reservation = reservation
				@user = user 
			end

			def call 
				{
					data: Reservations::Representers::Data.new(reservation, user).call 
				}
			end
		end
	end
end
