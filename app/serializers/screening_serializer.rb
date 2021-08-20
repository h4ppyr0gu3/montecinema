class ScreeningSerializer
  include JSONAPI::Serializer
  attributes :additional_cost, :airing_time, :seats_available

  belongs_to :movie
  belongs_to :cinema
end
