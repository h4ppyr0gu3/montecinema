class CinemaSerializer
  include JSONAPI::Serializer
  attributes :cinema_number, :total_seats

  has_many :screenings
end
