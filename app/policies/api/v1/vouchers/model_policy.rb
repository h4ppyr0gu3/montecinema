class Api::V1::Vouchers::ModelPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = Vouchers::Model
    end
    attr_reader :user, :scope
  end

  def initialize(user, voucher)
    @user = user
    @voucher = voucher
  end

  def update?
    user.admin?
  end

  def create?
    user.admin? || user.support?
  end

  attr_reader :user, :voucher
end