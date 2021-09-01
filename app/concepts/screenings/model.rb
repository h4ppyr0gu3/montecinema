module Screenings
	class Model < ApplicationRecord
		self.table_name = :screenings
		belongs_to :cinema, class_name: "Cinemas::Model" 
		belongs_to :movie, class_name: "Movies::Model" 
    has_many :reservations, dependent: :destroy, class_name: "Reservations::Model", foreign_key: :screening_id
    has_many :seats, through: :reservations, class_name: "Seats::Model"
	end
end