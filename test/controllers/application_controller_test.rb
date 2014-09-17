require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should correctly render task count" do
  	get :index
    assert_response :success
    assert_not_nil assigns(:task_count)

    assert_select '[data-page-type="tasks"] .black-overlay', {:count => 1, :text => "5"},
      "Wrong task count rendered"
  end

  test "should not render task count if there are none" do # TODO fix me !
  	# get :index
    # assert_response :success
    # assert_not_nil assigns(:task_count)

    # assert_select '[data-page-type="tasks"] .black-overlay', {:count => 1, :text => "5"},
      # "Wrong task count rendered"
  end

end
