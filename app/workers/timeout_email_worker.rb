class TimeoutEmailWorker
  include Sidekiq::Worker
  def perform screening
    reservations = ReservationRepository.new.where(screening_id: screening.id, confirmed: false)
    reservations.map do |reservation|
      user = Users::UserRepository.find_by_id(reservation.user_id)
      ReservationMailer.with(user: user, reservation: reservation).reservation_cancelled.deliver_now
    end
  end
end
