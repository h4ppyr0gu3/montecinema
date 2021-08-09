module Quickfix
	extend ActiveSupport::Concern
	def save_if item, action
		if item.save
			render json: {success: "#{action} successfully"}, status: :ok
		else
			render json: item.errors 
		end
	end
end