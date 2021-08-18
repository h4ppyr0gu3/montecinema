class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :authenticate_user
  attr_reader :current_user


  def authenticate_user
    @current_user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @current_user #|| puts 'Invalid token'
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    else
      render json: 'Missing token'
    end
  end
end
