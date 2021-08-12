require 'rails_helper'

RSpec.describe Screening, type: :model do
  context 'with screening and cinema' do
    it 'cinema & movie present' do
      create_movie
      create_cinema
      screening = described_class.new(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening.validate
      expect(screening.errors.count).to be(0)
    end

    it 'only cinema present' do
      create_cinema
      screening = described_class.new(
        airing_time: Time.zone.now,
        cinema_id: Cinema.last.id
      )
      screening.validate
      expect(screening.errors.count).to be > 0
    end

    it 'only movie present' do
      create_movie
      screening = described_class.new(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id
      )
      screening.validate
      expect(screening.errors.count).to be > 0
    end
  end

  context 'when cinema screenings overlap' do
    it 'valid screening times' do
      create_movie
      create_cinema
      described_class.create(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening = described_class.new(
        airing_time: Time.zone.now + 2.hours,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening.validate
      expect(screening.errors.count).to be == 0
    end

    it 'invalid screening times' do
      create_movie
      create_cinema
      described_class.create(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening = described_class.new(
        airing_time: Time.zone.now + 30.minutes,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      expect { screening.validate }.to raise_error(StandardError)
    end
  end
end

def create_movie
  Movie.create(
    title: 'The Mask',
    director: 'David Rogers',
    description: 'Funniest movie ever',
    genre: 'Comedy',
    length_mins: '120'
  )
end

def create_cinema
  Cinema.create(
    cinema_number: 10
  )
end
