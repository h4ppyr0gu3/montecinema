class Api::V1::Cinemas::ModelPolicy
  def initialize(user, cinema)
    @user = user
    @cinema = cinema
  end

  def show?
    user.present?
  end

  def create?
    user.admin? || user.support?
  end

  def destroy?
    create?
  end

  attr_reader :user, :cinema
end