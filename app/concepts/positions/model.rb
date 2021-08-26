module Positions
	class Model < ApplicationRecord
		self.table_name = :positions
		belongs_to :reservation, class_name: "Reservations::Model"
  	belongs_to :seat, class_name: "Seats::Model"
  end
end
