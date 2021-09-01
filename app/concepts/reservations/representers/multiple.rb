module Reservations
	module Representers
		class Multiple
			attr_reader :reservations, :user
			def initialize reservations, user
				@reservations = reservations
				@user = user
			end

			def call
				{
					data: 
					reservations.map do |reservation|
						Reservations::Representers::Data.new(reservation, user).call 
					end
				}
			end
		end
	end
end
