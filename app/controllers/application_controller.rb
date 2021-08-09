# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json
  include Quickfix

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password])
  end
end
