require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user)
  end

end
