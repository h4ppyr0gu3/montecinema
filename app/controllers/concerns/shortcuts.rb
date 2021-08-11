module Shortcuts
	extend ActiveSupport::Concern
	def conditional_render item
		if item.save
			render json: item, status: :created
		else
			render json: item.errors, status: :bad_request
		end
	end
end