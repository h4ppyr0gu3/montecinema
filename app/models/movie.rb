class Movie < ApplicationRecord
	has_many :screenings, dependent: :destroy
	before_validation :clean_params

	private 

	def clean_params
		self.title = self.title.downcase
		self.director = self.director.downcase
		self.genre = self.genre.downcase
		self.length = DateTime.parse(self.length).strftime("%H:%M")
	end
end
