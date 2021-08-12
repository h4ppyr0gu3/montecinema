class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy

  validates :director, :genre, :description, :length_mins, :title, presence: true

end
