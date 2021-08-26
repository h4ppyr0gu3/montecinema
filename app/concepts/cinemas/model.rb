module Cinemas
	class Model < ApplicationRecord
		self.table_name = :cinemas
		has_many :seats, 
							dependent: :destroy, 
							class_name: "Seats::Model", 
							foreign_key: :cinema_id
	  has_many :screenings, 
	  					dependent: :destroy, 
	  					class_name: "Screenings::Model", 
	  					foreign_key: :cinema_id
	  has_many :reservations, 
	  					dependent: :destroy, 
	  					class_name: "Reservations::Model", 
	  					foreign_key: :cinema_id
	end
end

