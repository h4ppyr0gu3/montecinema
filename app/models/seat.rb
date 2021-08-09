class Seat < ApplicationRecord
  belongs_to :cinema, required: false
end
