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

	test "should create new project" do
		assert_difference('Project.count') do
			@request.headers["Accept"] = "application/json"
			params = { :name => 'TestProject', :complete => 31, :description => "Test"}
			post :create, :project => params, Accept: "application/json"
		end
		assert_response :success
	end

	test "should not create new project if parameters are invalid" do
		@request.headers["Accept"] = "application/json"
		
		params = { :name => '', :complete => 31, :description => "Test"}
		post :create, :project => params, Accept: "application/json"
		assert_response 422
	end

end
