# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
	before_action :configure_permitted_parameters, if: :devise_controller?
	respond_to :json

	 protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :email, bank_attributes: [:bank_name, :bank_account]])
  end
end
