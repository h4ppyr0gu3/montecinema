# frozen_string_literal: true

class Cinema < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :screenings, dependent: :delete_all
  validates :cinema_number, uniqueness: true
end
