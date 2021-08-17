ENV['RAILS_ENV'] = 'test'
require 'database_cleaner'
require File.expand_path('../../config/environment', __FILE__)


Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include SpecHelpers::Creator

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.silence_filter_announcements = true
  # config.warnings = false
  config.filter_run :focus
  # config.disable_monkey_patching!
  # config.infer_spec_type_from_file_location!
  # config.shared_context_metadata_behavior = :apply_to_host_groups
  # config.default_formatter = "doc" if config.files_to_run.one?
  # config.profile_examples = 10
  # config.order = :random
  # config.use_transactional_fixtures = true
  # config.filter_rails_from_backtrace!
  # config.expose_dsl_globally = false
  
  Kernel.srand config.seed

# DatabaseCleaner.strategy = :truncation
  # DatabaseCleaner.strategy = :truncation, {
  #   pre_count: true
  # }

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end


end

