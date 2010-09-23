# $Id: preference_test.rb 296 2007-01-30 22:31:51Z garrett $

require 'test_helper'

class PreferenceTest < ActiveSupport::TestCase
  
  fixtures :preferences
  
  def test_nothing
    assert_equal 1, 1
  end
  
end
