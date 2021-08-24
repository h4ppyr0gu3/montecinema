module Movies
  class Model < ApplicationRecord
    self.table_name = :movies
    has_many :screenings, class_name: "Screenings::Model", dependent: :destroy, foreign_key: :movie_id
  end
end
