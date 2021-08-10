# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Screening, type: :model do
  context 'screening can only be added to a cinema with a movie' do
    it 'needs a cinema to be created' do
      movie = Movie.create(
        title: 'The Mask',
        director: 'David Rogers',
        description: 'Funniest movie ever',
        genre: 'Comedy',
        length: '1:20'
      )
      movie.validate
      expect(movie.errors.count).to be(0)
      screening = movie.screenings.create(airing_time: Time.zone.now)
    end
  end
end
