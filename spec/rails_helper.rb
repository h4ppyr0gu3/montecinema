require 'spec_helper'
require 'simplecov'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rails/all'
require 'rspec/rails'
require 'devise'
# include Rack::Test::Methods
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.include ActionController::RespondWith, type: :controller
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  SimpleCov.start
  config.include Devise::Test::IntegrationHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
