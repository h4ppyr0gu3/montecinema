require 'rails_helper'

RSpec.describe Screening, type: :model do
  context 'with screening and cinema' do
    it 'cinema & movie present' do
      create(:cinema)
      create(:movie)
      screening = described_class.new(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening.validate
      expect(screening.errors.count).to be(0)
    end

    it 'only cinema present' do
      create(:cinema)
      screening = described_class.new(
        airing_time: Time.zone.now,
        cinema_id: Cinema.last.id
      )
      screening.validate
      expect(screening.errors.count).to be > 0
    end

    it 'only movie present' do
      create(:movie)
      screening = described_class.new(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id
      )
      screening.validate
      expect(screening.errors.count).to be > 0
    end
  end

  context 'when cinema screenings overlap' do
    before do
      create(:cinema)
      create(:movie)
    end

    it 'valid screening times' do
      described_class.create(
        airing_time: Time.zone.now,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening = described_class.new(
        airing_time: Time.zone.now + 3.hours,
        movie_id: Movie.last.id,
        cinema_id: Cinema.last.id
      )
      screening.validate
      expect(screening.errors.count).to be == 0
    end

    it 'invalid screening times' do
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
