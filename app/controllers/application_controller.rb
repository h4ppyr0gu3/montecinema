class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  include Pundit

  def pundit_user
    current_users_model
  end

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end
end
