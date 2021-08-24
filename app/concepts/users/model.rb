module Users
	class Model < ApplicationRecord
		self.table_name = :users
	  
	  has_secure_password

		has_one :jti, dependent: :destroy
	  has_many :reservations, dependent: :destroy

	  enum role: { client: 0, support: 1, admin: 2 }
	end
end


# class User < ApplicationRecord
#   has_one :jti, dependent: :destroy
#   before_save { email.downcase! }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
#   validates :email, presence: true,
#                     length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, length: { minimum: 6 }
#   after_create :create_jti
#   has_many :reservations, dependent: :destroy

#   enum role: { client: 0, support: 1, admin: 2 }

#   private

#   def create_jti
#     jti = Jti.new(user_id: id, jti: SecureRandom.alphanumeric(10))
#     jti.create unless jti.save
#   end
# end
