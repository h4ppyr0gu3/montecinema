class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :cinema

  before_validation :ensure_airing_times

  private

  def ensure_airing_times
    screenings = Screening.where(cinema_id: cinema_id)
    screenings.each do |screening|
      movie = Movie.find(screening.movie_id)
      minutes = movie.length
      earliest_possible_time = screening.airing_time + minutes.minutes
      raise StandardError, 'Time slot already taken' if airing_time < earliest_possible_time
    end
  end
end
