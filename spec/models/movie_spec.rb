require 'rails_helper'

RSpec.describe Movies::Model, type: :model do
  it 'title not present' do
    movie = described_class.new(
      director: 'David Rogers',
      description: 'Funniest movie ever',
      genre: 'Comedy',
      length: '120'
    )
    expect { movie.save! }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'director not present' do
    movie = described_class.new(
      title: 'The Mask',
      description: 'Funniest movie ever',
      genre: 'Comedy',
      length: '120'
    )
    expect { movie.save! }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'description not present' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      genre: 'Comedy',
      length: '120'
    )
    expect { movie.save! }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'genre not present' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      description: 'Funniest movie ever',
      length: '120'
    )
    expect { movie.save! }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'length not present' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      description: 'Funniest movie ever',
      genre: 'Comedy'
    )
    expect { movie.save! }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'valid entry' do
    movie = described_class.new(
      title: 'The Mask',
      director: 'David Rogers',
      description: 'Funniest movie ever',
      genre: 'Comedy',
      length: '120'
    )
    expect { movie.save! }.to change(described_class, :count).by(1)
  end
end
