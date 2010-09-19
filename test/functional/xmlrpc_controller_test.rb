require File.dirname(__FILE__) + '/../test_helper'
require 'xmlrpc_controller'

# Re-raise errors caught by the controller.
class XmlrpcController; def rescue_action(e) raise e end; end

class XmlrpcControllerTest < ActiveSupport::TestCase
  def test_xmlrpc_works
    assert false, "Make webservice controller work!"
  end
end
