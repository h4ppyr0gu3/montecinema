module Vouchers
	class Model < ApplicationRecord
		self.table_name = :vouchers
		has_many :redeemables, class_name: 'Redeemables::Model'
		has_many :users, through: :redeemables, class_name: 'Users::Model'
	end
end
