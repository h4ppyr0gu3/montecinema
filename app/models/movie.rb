class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy

  validates :director, :genre, :description, :length, :title, presence: true

end
