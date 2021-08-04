 class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,  jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  before_validation :append_jti_attribute

  private

  def append_jti_attribute
    self.jti = SecureRandom.uuid
  end
end
