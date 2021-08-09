class Cinema < ApplicationRecord
	has_many :seats, dependent: :delete_all
	has_many :screenings, dependent: :delete_all
end
