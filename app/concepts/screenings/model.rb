module Screenings
	class Model < ApplicationRecord
		self.table_name = :screenings
		belongs_to :cinema, class_name: "Cinemas::Model" 
		belongs_to :movie, class_name: "Movies::Model" 
	end
end