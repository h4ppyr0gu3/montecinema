module Quickfix
	extend ActiveSupport::Concern
	def save_if item
		if item.save
			render json: item, status: :created
		else
			render json: item.errors, status: :bad_request
		end
	end
end