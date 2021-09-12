module Redeemables
	class Model < ApplicationRecord
		self.table_name = :redeemables
		belongs_to :user, class_name: 'Users::Model', dependent: :destroy
		belongs_to :voucher, class_name: 'Vouchers::Model', dependent: :destroy
	end
end
