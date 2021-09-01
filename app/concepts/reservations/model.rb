module Reservations
	class Model < ApplicationRecord
		self.table_name = :reservations
	  belongs_to :user, 
	  						class_name: "Users::Model"
	  has_many :positions, 
	  						inverse_of: :reservation, 
	  						dependent: :destroy, 
	  						class_name: "Positions::Model", 
	  						foreign_key: :reservation_id
	  has_many :seats, 
	  						through: :positions, 
	  						dependent: :destroy, 
	  						class_name: "Seats::Model", 
	  						foreign_key: :reservation_id
	  belongs_to :movie, 
	  						class_name: "Movies::Model" 
	  belongs_to :screening, 
	  						class_name: "Screenings::Model"
	  belongs_to :cinema,
	  						class_name: "Cinemas::Model"
	end
end
