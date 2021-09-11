class Api::V1::Reservations::ModelPolicy
  def initialize(user, reservation)
    @user = user
    @reservation = reservation
  end

  def index?
    user.present?
  end

  def show?
    user.reservations.include?(reservation) || user.admin? || user.support?
  end

  def create?
    index?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  attr_reader :user, :reservation
end