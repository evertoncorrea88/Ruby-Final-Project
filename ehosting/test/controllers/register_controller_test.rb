require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get check_in" do
    get :check_in
    assert_response :success
  end

  test "should get list_check_in" do
    get :list_check_in
    assert_response :success
  end

end
