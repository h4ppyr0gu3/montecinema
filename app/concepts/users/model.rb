module Users
	class Model < ApplicationRecord
		self.table_name = :users
	  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  	include DeviseTokenAuth::Concerns::User
	  has_many :reservations, dependent: :destroy

	  enum role: { client: 0, support: 1, admin: 2 }
	end
end
