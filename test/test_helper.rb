ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "mocha/setup"
require_relative "factories"

class ActiveSupport::TestCase
  FIXTURES = File.expand_path( "#{File.dirname(__FILE__)}/fixtures" )

  def read_fixture( fixture_name )
    File.read( "#{FIXTURES}/#{fixture_name}" )
  end
end
