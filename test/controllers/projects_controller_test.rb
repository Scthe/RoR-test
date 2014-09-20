require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

	test "should get index" do
		get :index
		assert_response :success
		assert_template :index
		assert_template layout: "layouts/application"
	end

	test "should get show" do
		get :show, id: 0
		assert_response :success
		assert_template :show
		assert_template layout: "layouts/application"
	end

	test "should get edit" do
		get :edit, id: 0
		assert_response :success
		assert_template :edit
		assert_template layout: "layouts/application"
	end

	test "should get new" do
		get :new
		assert_response :success
		assert_template :new
		assert_template layout: "layouts/application"
	end

end
