require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'

require 'capybara/rspec'
require 'capybara/rails'
require 'selenium/webdriver'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|

  # Add spec supports
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

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

  config.before(:each, type: :system, js: true) do
    driven_by :headless_chrome
  end

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include Capybara::DSL

  config.include Devise::Test::ControllerHelpers, type: :controller

  config.include FactoryBot::Syntax::Methods
end

Capybara.default_host = "http://127.0.0.1"

Capybara.configure do |config|
  config.always_include_port = true
end

Capybara.register_driver(:headless_chrome) do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  # options.add_argument('--headless')
  # options.add_argument('--no-sandbox')
  # options.add_argument('--disable-dev-shm-usage')

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 1

  Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
  )
end

Capybara.default_max_wait_time = 5