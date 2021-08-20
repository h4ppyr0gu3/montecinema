class ReservationSerializer
  include JSONAPI::Serializer
  attributes :cinema, :seats, :screening 

  def cinema
    object.cinemas
  end

  def seats
    object.seats 
  end

  def screening
    object.screenings
  end
end
