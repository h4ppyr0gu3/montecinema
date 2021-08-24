module Reservations
	class Model < ApplicationRecord
		self.table_name = :reservations
	  belongs_to :user, dependent: :destroy
	  has_many :positions, inverse_of: :reservation, dependent: :destroy
	  has_many :seats, through: :positions, dependent: :destroy, class_name: "Seats::Model"
	end
