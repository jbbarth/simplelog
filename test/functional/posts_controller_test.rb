# $Id: posts_controller_test.rb 296 2007-01-30 22:31:51Z garrett $

require File.dirname(__FILE__) + '/../test_helper'
require 'admin/posts_controller'

# Re-raise errors caught by the controller.
class Admin::PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < Test::Unit::TestCase
  
  fixtures :authors, :posts, :tags
  
  def setup
    @controller = Admin::PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    # let's set cookies for authentication so that we can do tests... the admin section is protected
    @request.cookies[SL_CONFIG[:USER_EMAIL_COOKIE]] = CGI::Cookie.new(SL_CONFIG[:USER_EMAIL_COOKIE], authors(:garrett).email)
    @request.cookies[SL_CONFIG[:USER_HASH_COOKIE]] = CGI::Cookie.new(SL_CONFIG[:USER_HASH_COOKIE], authors(:garrett).hashed_pass)
  end
  
  def test_post_list
    get :list
    assert_template 'list'
    assert(@response.has_template_object?('posts'))
  end
  
  def test_post_new
    get :new
    assert_template 'new'
    assert(@response.has_template_object?('post'))
    assert_response :success
  end
  
  def test_post_create
    c = Post.count
    post :create, :post => {:author_id => 1, :title => 'test post', :body_raw => 'test content'}
    assert_redirected_to '/admin/posts'
    assert_equal c+1, Post.count
  end
  
  def test_post_edit
    get :edit, :id => 1
    assert_template 'edit'
    assert(@response.has_template_object?('post'))
    assert(assigns('post').valid?)
    assert_response :success
  end
  
  def test_post_update
    post :update, :id => 1
    assert_redirected_to '/admin/posts'
  end
  
  def test_post_destroy
    assert_not_nil Post.find(1)
    get :destroy, :id => 1
    assert_redirected_to '/admin/posts'
    assert_raise(ActiveRecord::RecordNotFound) { p = Post.find(1) }
  end
  
end
