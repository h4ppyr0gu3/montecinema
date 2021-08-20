class MovieSerializer
  include JSONAPI::Serializer
  attributes :genre, :title, :length, :director, :description

  has_many :screenings
end
