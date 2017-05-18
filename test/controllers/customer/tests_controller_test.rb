require 'test_helper'

class Customer::TestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get finnish" do
    get :finnish
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
