class Jti < ApplicationRecord
  belongs_to :user
  validates :jti, uniqueness: true
end
