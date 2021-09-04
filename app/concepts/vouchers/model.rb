module Vouchers
	class Model < ApplicationRecord
		self.table_name = :vouchers
		has_many :user_vouchers, class_name: 'UserVouchers::Model', foreign_key: :voucher_id
		has_many :users, through: :user_vouchers, class_name: 'Users::Model'
	end
end
