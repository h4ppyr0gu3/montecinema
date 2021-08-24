module Movies
  class Model < ApplicationRecord
    self.table_name = :movies
    has_many :screenings, dependent: :destroy
  end
end
