class Voucher < ApplicationRecord
	validates :code, uniqueness: true
	validates :expiration_date, presence: true
	validates :points_required, presence: true

	scope :valid, -> { where(:expiration_date > Time.zone.now)}
end
