class Api::V1::Movies::ModelPolicy
  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def show?
    user.present?
  end

  def create?
    user.admin?
  end

  def destroy?
    create?
  end

  def update?
    create?
  end

  attr_reader :user, :movie
end