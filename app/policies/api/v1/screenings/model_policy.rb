class Api::V1::Screenings::ModelPolicy
  def initialize(user, screening)
    @user = user
    @screening = screening
  end

  def create?
    user.admin? || user.support?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  attr_reader :user, :screening
end