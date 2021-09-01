module Users
	class Model < ApplicationRecord
		self.table_name = :users
	  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  	include DeviseTokenAuth::Concerns::User
	  has_many :reservations, dependent: :destroy, class_name: "Reservations::Model", foreign_key: :user_id
	  has_many :redeemables, class_name: 'Redeemables::Model'
	  has_many :vouchers, through: :redeemables, class_name: 'Vouchers::Model'

	  enum role: { client: 0, support: 1, admin: 2 }
	end
end
