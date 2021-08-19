class User < ApplicationRecord
  has_one :jti, dependent: :destroy
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  after_create :create_jti

  private

  def create_jti
    jti = Jti.new(user_id: id, jti: SecureRandom.alphanumeric(10))
    jti.create unless jti.save
  end
end
