# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  before_save :parse_params

  validates :director, :genre, :description, :length, :title, presence: true

  private

  def parse_params
    self.title = title.downcase
    self.director = director.downcase
    self.genre = genre.downcase
    self.length = Time.zone.parse(length.to_s).strftime('%H:%M')
  end
end
