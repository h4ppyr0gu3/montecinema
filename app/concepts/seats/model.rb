module Seats
	class Model < ApplicationRecord
		self.table_name = :seats
		belongs_to :cinema, class_name: "Cinemas::Model" 
	  has_many :positions, dependent: :destroy, inverse_of: :seat, class_name: "Positions::Model", foreign_key: :seat_id
	  has_many :reservations, through: :positions, class_name: "Reservations::Model"
	  has_many :screenings, through: :reservations, class_name: "Screenings::Model"
	end
end