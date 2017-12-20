require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get join" do
    get :join
    assert_response :success
  end

  test "should get login_process" do
    get :login_process
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

  test "should get join_process" do
    get :join_process
    assert_response :success
  end

end
