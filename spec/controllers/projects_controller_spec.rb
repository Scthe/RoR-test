require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

	before(:each) do
		@project_a = build(:project_a)
		@project_b = build(:project_b)
		@projects = [ @project_a, @project_b]

		@user = double member_of?: true, id: 1, projects: @projects, tasks_to_do: []
		controller.instance_variable_set(:@user, @user)

		@project = double destroy: nil
	end

	describe "smoke tests" do

		it "should get index" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("index")
			expect(response).to render_template("layouts/application")

			expect(assigns(:projects)).to eq(@projects)
		end

		it "should get show" do
			allow(Project).to receive(:find_).and_return(@project_a)
			get :show, id: 0
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/show")
			expect(response).to render_template("layouts/application")
			expect(assigns(:project)).to eq(@project_a)
		end

		it "should get edit" do
			allow(Project).to receive(:find_).and_return(@project)
			get :edit, id: 0
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/edit")
			expect(response).to render_template("layouts/application")
			expect(assigns(:project)).to eq(@project)
		end

		it "should get new" do
			get :new
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/new")
			expect(response).to render_template("layouts/application")
			expect(assigns(:project)).to be_a_new(Project)
		end
	end

	context "fail to get project" do
		context "show" do
			it "should 403 if project not found - show" do
				expect(Project).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)
				get :show, id: 0
				expect(response).to have_http_status(403)
			end

			it "should 403 if user is not memeber of the project - show" do
				expect(@user).to receive(:member_of?).and_return( false)
				get :show, id: 0
				expect(response).to have_http_status(403)
			end
		end

		context "edit" do
			it "should 403 if project not found - edit" do
				expect(Project).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)
				get :edit, id: 0
				expect(response).to have_http_status(403)
			end

			it "should 403 if user is not memeber of the project - edit" do
				expect(@user).to receive(:member_of?).and_return( false)
				get :edit, id: 0
				expect(response).to have_http_status(403)
			end
		end
	end

	context "API" do

		describe "create" do
			it "should return created project" do
				@project_a.id = 134
				r = true, @project_a
				expect(Project).to receive(:create).and_return( r)

				@request.headers["Accept"] = "application/json"
				post :create

				url = controller.url_for( project_path (@project_a) )
				body = JSON.parse(response.body)

				expect(body["name"]).to eq(@project_a.name)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(201)
			end

			it "should return list of errors if data is not ok" do
				l = { "a" => 1, "b" => 2}
				r = false, (double errors: l)
				expect(Project).to receive(:create).and_return( r)

				@request.headers["Accept"] = "application/json"
				post :create

				body = JSON.parse(response.body)
				expect(body).to match_array( l.keys)

				expect(response).to have_http_status(422)
			end
		end

		describe "update" do
			it "should return status ok for correct data" do
				@project_a.id = 134
				r = true, @project_a
				expect(Project).to receive(:update).and_return( r)

				h = {
					:id => @project_a.id,
					:tasksToRemove => "[]",
					:peopleToRemove => "[]",
				:peopleToAdd => "[]" }

				@request.headers["Accept"] = "application/json"
				put :update, h

				url = controller.url_for( project_path (@project_a) )
				body = JSON.parse(response.body)

				expect(body["name"]).to eq(@project_a.name)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(200)
			end

			it "should not update on incorrect data" do
				@project_a.id = 134
				l = { "a" => 1, "b" => 2}
				r = false, (double errors: l)
				expect(Project).to receive(:update).and_return( r)

				h = {
					:id => @project_a.id,
					:tasksToRemove => "[]",
					:peopleToRemove => "[]",
				:peopleToAdd => "[]" }

				@request.headers["Accept"] = "application/json"
				put :update, h

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy
				expect(body).to match_array( l.keys)

				expect(response).to have_http_status(422)
			end

			it "should not update not existing project" do
				@project_a.id = 134
				expect(Project).to receive(:update).and_raise( ActiveRecord::RecordNotFound)

				h = {
					:id => @project_a.id,
					:tasksToRemove => "[]",
					:peopleToRemove => "[]",
				:peopleToAdd => "[]" }

				@request.headers["Accept"] = "application/json"
				put :update, h

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(403)
			end

			it "should raise error on not parseable id arrays" do
				@project_a.id = 134
				r = true, @project_a
				allow(Project).to receive(:update).and_return( r)

				@request.headers["Accept"] = "application/json"
				put :update, id: @project_a.id

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(422)
			end
		end

		describe "destroy" do
			it "should return url to project list" do
				expect(Project).to receive(:find_).and_return( @project)

				@request.headers["Accept"] = "application/json"
				delete :destroy, id: 0

				url = controller.url_for( projects_path)
				body = JSON.parse(response.body)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(200)
			end

			it "should not delete project that does not exists" do
				expect(Project).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)

				@request.headers["Accept"] = "application/json"
				delete :destroy, id: 0

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(422)
			end
		end

	end
end
