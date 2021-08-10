class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  before_validation :parse_params

  private

  def parse_params
    self.title = title.downcase
    self.director = director.downcase
    self.genre = genre.downcase
    self.length = DateTime.parse(length.to_s).strftime('%H:%M')
  end
end
