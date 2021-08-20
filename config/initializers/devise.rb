# # frozen_string_literal: true

# Devise.setup do |config|
#   # config.parent_controller = 'DeviseController'
#   config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
#   # config.mailer = 'Devise::Mailer'
#   # config.parent_mailer = 'ActionMailer::Base'
#   require 'devise/orm/active_record'
#   # config.authentication_keys = [:email]
#   # config.request_keys = []
#   config.case_insensitive_keys = [:email]
#   config.strip_whitespace_keys = [:email]
#   # config.params_authenticatable = true
#   # config.http_authenticatable = false
#   # config.http_authenticatable_on_xhr = true
#   # config.http_authentication_realm = 'Application'
#   # config.paranoid = true
#   config.skip_session_storage = %i[http_auth params_auth]
#   # config.clean_up_csrf_token_on_authentication = true
#   # config.reload_routes = true
#   config.stretches = Rails.env.test? ? 1 : 12
#   # config.pepper = '94eb5a82624e61db596a0c5b6f260430c6e1e9301c0c2db13f2bc449880d2584e2eaece0af35c02a1b61bf7a2b3e0290ba301b369615196f6101d576144996d2'
#   # config.send_email_changed_notification = false
#   # config.send_password_change_notification = false
#   # config.allow_unconfirmed_access_for = 2.days
#   # config.confirm_within = 3.days
#   config.reconfirmable = true
#   # config.confirmation_keys = [:email]
#   # config.remember_for = 2.weeks
#   config.expire_all_remember_me_on_sign_out = true
#   # config.extend_remember_period = false
#   # config.rememberable_options = {}
#   config.password_length = 6..128
#   config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
#   # config.timeout_in = 30.minutes
#   # config.lock_strategy = :failed_attempts
#   # config.unlock_keys = [:email]
#   # config.unlock_strategy = :both
#   # config.maximum_attempts = 20
#   # config.unlock_in = 1.hour
#   # config.last_attempt_warning = true
#   # config.reset_password_keys = [:email]
#   config.reset_password_within = 6.hours
#   # config.sign_in_after_reset_password = true
#   # config.encryptor = :sha512
#   # config.scoped_views = false
#   # config.default_scope = :user
#   # config.sign_out_all_scopes = true
#   # config.navigational_formats = ['*/*', :html]
#   config.sign_out_via = :delete
#   # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'

#   # ==> Warden configuration
#   # If you want to use other strategies, that are not supported by Devise, or
#   # change the failure app, you can configure them inside the config.warden block.
#   #
#   # config.warden do |manager|
#   #   manager.intercept_401 = false
#   #   manager.default_strategies(scope: :user).unshift :some_external_strategy
#   # end
#   # config.omniauth_path_prefix = '/my_engine/users/auth'
#   # ActiveSupport.on_load(:devise_failure_app) do
#   #   include Turbolinks::Controller
#   # end
#   # config.sign_in_after_change_password = true
#   config.jwt do |jwt|
#     jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
#     jwt.dispatch_requests = [
#       ['POST', %r{^/api/v1/users$}],
#       ['POST', %r{^/users/sign_in$}]
#     ]
#   end
# end
