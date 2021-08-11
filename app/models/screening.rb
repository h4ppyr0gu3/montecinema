class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :cinema

  before_validation :ensure_airing_times

  private

  def ensure_airing_times
    screenings = Screening.where(cinema_id: cinema_id)
    screenings.each do |screening|
      movie = Movie.find(screening.movie_id)
      hours = movie.length.strftime('%H').to_i
      minutes = movie.length.strftime('%M').to_i
      earliest_possible_time = screening.airing_time + hours.hours + minutes.minutes
      raise StandardError, 'Time slot already taken' if airing_time < earliest_possible_time
    end
  end
end
