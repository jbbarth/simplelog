# $Id: update_test.rb 229 2006-08-23 18:02:08Z garrett $

require 'test_helper'

class UpdateTest < ActiveSupport::TestCase
  
  fixtures :updates

  def test_check_updates
    u = Update.find(:first)
    assert_equal false, u.update_available
  end
  
end
