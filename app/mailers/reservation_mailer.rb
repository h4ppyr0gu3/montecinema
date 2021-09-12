class ReservationMailer < ApplicationMailer

	def reservation_created
    @user = params[:user]
  	@reservation = params[:reservation]
    mail(to: @user.email, subject: 'Reservartion created')
  end

  def reservation_cancelled
  	@user = params[:user]
  	@reservation = params[:reservation]
    mail(to: @user.email, subject: 'Reservartion cancelled')
  end
end