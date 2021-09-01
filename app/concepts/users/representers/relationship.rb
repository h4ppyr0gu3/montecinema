module Users
	module Representers
		class Relationship
			attr_reader :user 
			def initialize user 
				@user = user 
			end

			def call
				{
					id: user.id,
					attributes: {
						first_name: user.first_name,
						last_name: user.last_name,
						email: user.email,
						points_earned: user.points_earned,
						points_redeemed: user.points_redeemed
					}
				}
			end
		end
	end
end