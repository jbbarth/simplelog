ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # TODO: see if those 2 lines are still usefull
  self.use_transactional_fixtures = false # we're using MyISAM in places, so we can't do this
  self.use_instantiated_fixtures  = false # faster if we don't instantiate these
end
