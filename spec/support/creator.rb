module SpecHelpers
  module Creator
    def create_movie
      Movie.create(
        title: 'Nuggets',
        length: '125',
        description: 'A little bit of gibberish is always good i guess',
        director: 'David Rogers',
        genre: 'The Usual'
      )
    end

    def create_another_movie
      Movie.create(
        title: 'Nuggets 2',
        length: '225',
        description: 'A little bit of gibberish is always good round 2',
        director: 'David Rogers',
        genre: 'The Usual'
      )
    end

    def create_cinema; end

    def create_user; end

    def create_something_else; end
  end
end
