class Screening < ApplicationRecord
	belongs_to :movies
	belongs_to :cinema
end
