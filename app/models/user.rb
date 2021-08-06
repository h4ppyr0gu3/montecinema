# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  before_validation :append_jti_attribute

  enum role: { client: 0, support: 1, admin: 2 }

  private

  def append_jti_attribute
    self.jti = SecureRandom.uuid
  end
end
# May need additional validation after adding jti incase of large DB