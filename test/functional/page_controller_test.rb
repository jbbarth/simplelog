# $Id: page_controller_test.rb 300 2007-02-01 23:01:00Z garrett $

require 'test_helper'
require 'page_controller'

# Re-raise errors caught by the controller.
class PageController; def rescue_action(e) raise e end; end

class PageControllerTest < ActionController::TestCase
  def setup
    @controller = PageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
