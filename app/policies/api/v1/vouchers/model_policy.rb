class Api::V1::Vouchers::ModelPolicy
  def initialize(user, voucher)
    @user = user
    @voucher = voucher
  end

  def redeem?
    user.admin? || user.support?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  attr_reader :user, :voucher
end