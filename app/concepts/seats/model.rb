module Seats
	class Model < ApplicationRecord
		self.table_name = :seats
		belongs_to :cinema, class_name: "Cinemas::Model" 
	  has_many :positions, dependent: :destroy, inverse_of: :seat
	  has_many :reservations, through: :positions
	end
end