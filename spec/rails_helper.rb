# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

# Simple Cov
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/helpers/application_helper.rb'
end

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# DB Cleaner
require 'database_cleaner'

# Shoulda Matchers
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Capybara Settings
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara-screenshot/rspec'

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.server = :puma
Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3007

Capybara.default_driver = :firefox
Capybara.javascript_driver = :firefox
Capybara.app_host = 'http://127.0.0.1:3007'
Capybara.default_max_wait_time = 10

Capybara::Screenshot.register_driver(:firefox) do |driver, path|
  driver.browser.save_screenshot(path)
end
Capybara.save_path = ENV["capybara_screenshots_path"]

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  
  ## Custom
  # Include Factory Girl syntax to simplify calls to factories
  config.include FactoryBot::Syntax::Methods
  
  # Database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation, except: %w(ar_internal_metadata))
  end
  
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  
  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Include our custom helpers
  config.include RequestSpecHelper

  # Capybara Settings
  config.before(:suite) do
    Webpacker.compile
  end

  config.before(:each) do
    config.include Capybara::DSL
  end
end
