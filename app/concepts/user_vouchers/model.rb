class UserVouchers::Model < ApplicationRecord
	self.table_name = :user_vouchers
	belongs_to :user, class_name: "Users::Model"
	belongs_to :voucher, class_name: "Vouchers::Model"
end
