require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'turnip/capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'factory_girl'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('lib/**/*.rb')].each { |f| require f }

# load turnip steps
Dir.glob('spec/features/step_definitions/**/*steps.rb') { |f| load f, true }

Capybara.javascript_driver = :poltergeist
Capybara.server_port = 4002
Capybara.default_wait_time = 15
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
                                    window_size: [1280, 1024],
                                    timeout: 90)
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    FactoryGirl.reload
    DatabaseCleaner.clean
    ActionMailer::Base.deliveries.clear
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random

  Kernel.srand config.seed
end
