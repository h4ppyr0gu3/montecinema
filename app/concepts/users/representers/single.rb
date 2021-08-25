module Users
	module Representers
		class Single 
			attr_reader :user 
			def initialize user 
				@user = user 
			end

			def call
				{
					data: {
						id: user['id'],
						type: 'user',
						attributes: {
							first_name: user['first_name'],
							last_name: user['last_name'],
							email: user['email'],
							points_earned: user['points_earned'],
							points_redeemed: user['points_redeemed']
						},
						relationships: {
							reservations: {

							}
						}
					}
				}
			end
		end
	end
end
