class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken unless Rails.env = 'test'
  include ActionController::MimeResponds
  include Pundit

  def pundit_user
    current_users_model
  end

  def authenticate_users_model!
    unless Rails.env = 'test'
      authenticate_users_model!
    else
      @current_users_model = Users::Model.last
    end
  end

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end

  rescue_from StandardError do |e|
    Rails.logger.error(
      e.message + "\n" + e.backtrace[0, 10].join("\n\t")
    )

    if e.class == Pundit::NotAuthorizedError
      status = 401
      error = e.message
    else
      status = :bad_request
      error = e.message
    end

    render json: { type: e.class, error: error }, status: status
  end
end
