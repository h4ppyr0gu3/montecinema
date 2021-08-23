module Cinemas
	class Model < ApplicationRecord
		self.table_name = :cinemas
		has_many :seats, dependent: :destroy, class_name: "Seats::Model"
	  has_many :screenings, dependent: :delete_all
	  validates :cinema_number, uniqueness: true
	end
end

