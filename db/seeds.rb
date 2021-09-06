def seed_cinema(rows, columns, cinema_number)
  cinema = Cinemas::Model.create(cinema_number: cinema_number)
  cols = ('a'..'z').take(columns).to_a
  rows = (1..rows).to_a
  seats = cols.product(rows).map(&:join)
  seats.each do |seat_number|
    seat = cinema.seats.new(seat_number: seat_number)
    Rails.logger.error seat.errors.messages unless seat.save
  end
end

cinemas = [
  [10, 20, 1],
  [10, 10, 2],
  [10, 10, 3],
  [10, 10, 4],
  [10, 10, 5],
  [5, 10, 6],
  [5, 10, 7],
  [5, 10, 8],
  [5, 10, 9],
  [5, 4, 10]
]

def seed_users
  @user = Users::Model.create(
    first_name: 'David',
    last_name: 'Rogers',
    email: 'test@test.com',
    password: 'test123'
  )
  Users::Model.create(
    first_name: 'Lucy',
    last_name: 'Goosey',
    email: 'support@test.com',
    password: 'test123',
    role: :support
  )
  Users::Model.create(
    first_name: 'Admin',
    last_name: 'Powers',
    email: 'admin@test.com',
    password: 'test123',
    role: :admin
  )
end

def seed_movies
  Movies::Model.create(
    title: 'Autobiography',
    description: 'Best description',
    director: 'Me, Mario',
    length: 125,
    genre: 'comedy'
  )
  @movie = Movies::Model.create(
    title: 'Nobody',
    description: 'Best description',
    director: 'Not me, Mario',
    length: 90,
    genre: 'adventure'
  )
end

def seed_screenings
  @cinema = Cinemas::Model.find_by(cinema_number: 2)
  @screening = Screenings::Model.create(
    movie_id: @movie.id,
    cinema_id: @cinema.id,
    airing_time: Time.now + 5.days
  )
  Screenings::Model.create(
    movie_id: @movie.id,
    cinema_id: @cinema.id,
    airing_time: Time.now + 5.days + 3.hours
  )
  Screenings::Model.create(
    movie_id: @movie.id,
    cinema_id: @cinema.id,
    airing_time: Time.now + 5.days + 6.hours
  )
end

def seed_reservations
  seats = ['a1', 'a2', 'a3']
  reservation = Reservations::Model.create(
    cinema_id: @cinema.id,
    movie_id: @movie.id,
    screening_id: @screening.id,
    user_id: @user.id
  )
  seats.map do |seat|
    seat_model = Seats::Model.find_by(cinema_id: @cinema.id, seat_number: seat)
    Positions::Model.create(
      seat_id: seat_model.id,
      reservation_id: reservation.id
    )
  end
end

cinemas.each do |cinema|
  seed_cinema(cinema[0], cinema[1], cinema[2])
end
seed_users
seed_movies
seed_screenings
seed_reservations


