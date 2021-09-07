class Api::V1::Reservations::ModelPolicy
  def initialize(user, reservation)
    @user = user
    @reservation = reservation
  end

  def show?
    user.reservations.include? reservation
  end

  def create?
    user.present?
  end

  def update?
    user.reservations.include? reservation
  end

  def destroy?
    user.reservations.include? reservation 
  end

  attr_reader :user, :reservation
end