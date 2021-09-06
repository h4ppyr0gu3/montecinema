class ReservationMailerPreview < ActionMailer::Preview
	def reservation_created
		ReservationMailer.with(
			user: Users::Model.first,
			reservation: Reservations::Model.first
		).reservation_created
	end

	def reservation_cancelled
		ReservationMailer.with(
			user: Users::Model.first,
			reservation: Reservations::Model.first
		).reservation_cancelled
	end
end
