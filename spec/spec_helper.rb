ENV['RAILS_ENV'] ||= 'test'

$LOAD_PATH.unshift File.expand_path('..', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../app', __FILE__)

# Initialize combustion
require 'combustion'
Combustion.initialize! :active_record do

  Doorkeeper.configure do
    orm :active_record
  end

end

# Internal app
class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, class_name: "BsmOa::Role", join_table: 'roles_users'
  has_many :authorizations, through: :roles, class_name: "BsmOa::Authorization"
end

# ApplicationController
class ApplicationController < ActionController::Base
end

# Load rspec
require 'rspec/rails'
require 'shoulda-matchers'
require 'factory_girl'
require 'faker'
require 'database_cleaner'
require 'rails-controller-testing'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.render_views

  config.before :suite do
    FactoryGirl.find_definitions
  end

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods
end


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end

Rails::Controller::Testing.install
