require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'title not present' do
    movie = described_class.new(
      director: 'David Rogers',
      description: 'Funniest movie ever',
      genre: 'Comedy',
      length_mins: '120'
    )
    movie.validate
    expect(movie.errors.count).to be > 0
  end

  it 'director not present' do
    movie = described_class.new(
      title: 'The Mask',
      description: 'Funniest movie ever',
      genre: 'Comedy',
      length_mins: '120'
    )
    movie.validate
    expect(movie.errors.count).to be > 0
  end

  it 'description not present' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      genre: 'Comedy',
      length_mins: '120'
    )
    movie.validate
    expect(movie.errors.count).to be > 0
  end

  it 'genre not present' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      description: 'Funniest movie ever',
      length_mins: '120'
    )
    movie.validate
    expect(movie.errors.count).to be > 0
  end

  it 'length not present' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      description: 'Funniest movie ever',
      genre: 'Comedy'
    )
    movie.validate
    expect(movie.errors.count).to be > 0
  end

  it 'valid entry' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      description: 'Funniest movie ever',
      genre: 'Comedy',
      length_mins: '120'
    )
    movie.validate
    expect(movie.errors.count).to be == 0
  end
end
