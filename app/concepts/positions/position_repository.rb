module Positions
	class PositionRepository
		attr_reader :repository 
		def initialize
			@repository = Positions::Model
		end

		def create_position params
			repository.create!(params)
		end
	end
end