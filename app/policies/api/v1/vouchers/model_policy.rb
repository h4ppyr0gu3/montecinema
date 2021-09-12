class Api::V1::Vouchers::ModelPolicy
  def initialize(user, voucher)
    @user = user
    @voucher = voucher
  end

  def show?
    user.vouchers.include? voucher
  end

  def redeem?
    user.present? && ( user.admin? || user.support? )
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def purchase?
    user.present?
  end

  attr_reader :user, :voucher
end