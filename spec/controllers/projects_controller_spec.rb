require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

	login_user

	before(:each) do
		@project = double destroy: nil
	end

	describe "smoke tests" do

		it "#index" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("index")
			expect(response).to render_template("layouts/application")

			expect(assigns(:projects)).to be_truthy
		end

		it "#show" do
			allow(Project).to receive(:find_).and_return(@project)
			get :show, id: 0
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/show")
			expect(response).to render_template("layouts/application")
			expect(assigns(:project)).to eq(@project)
		end

		it "#edit" do
			allow(Project).to receive(:find_).and_return(@project)
			get :edit, id: 0
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/edit")
			expect(response).to render_template("layouts/application")
			expect(assigns(:project)).to eq(@project)
		end

		it "#new" do
			get :new
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/new")
			expect(response).to render_template("layouts/application")
			expect(assigns(:project)).to be_a_new(Project)
		end
	end

	context "fail to get project" do

		context "#show" do
			it "checks if project exists" do
				expect(Project).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)
				get :show, id: 0
				expect(response).to have_http_status(403)
			end

			it "checks if user is a member of the project" do
				allow(controller.current_user).to receive(:member_of?).and_return( false)
				get :show, id: 0
				expect(response).to have_http_status(403)
			end
		end

		context "#edit" do
			it "checks if project exists" do
				expect(Project).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)
				get :edit, id: 0
				expect(response).to have_http_status(403)
			end

			it "checks if user is a member of the project" do
				allow(controller.current_user).to receive(:member_of?).and_return( false)
				get :edit, id: 0
				expect(response).to have_http_status(403)
			end
		end
	end

	context "API" do

		describe "#create" do
			it "returns created project" do
				p = build(:project_a, id: 1234)
				r = true, p
				expect(Project).to receive(:create).and_return( r)

				@request.headers["Accept"] = "application/json"
				post :create

				url = controller.url_for( project_path (p) )
				body = JSON.parse(response.body)

				expect(body["name"]).to eq(p.name)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(201)
			end

			it "returns list of errors if data is not ok" do
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

		describe "#update" do
			it "returns status ok for correct data" do
				p = build(:project_a, id: 1234)
				r = true, p
				expect(Project).to receive(:update).and_return( r)

				h = {
					:id => p.id,
					:tasksToRemove => "[]",
					:peopleToRemove => "[]",
				:peopleToAdd => "[]" }

				@request.headers["Accept"] = "application/json"
				put :update, h

				url = controller.url_for( project_path (p) )
				body = JSON.parse(response.body)

				expect(body["name"]).to eq(p.name)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(200)
			end

			it "does not update with incorrect data" do
				l = { "a" => 1, "b" => 2}
				r = false, (double errors: l)
				expect(Project).to receive(:update).and_return( r)

				h = {
					:id => 1234,
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

			it "checks if project exists" do
				expect(Project).to receive(:update).and_raise( ActiveRecord::RecordNotFound)

				h = {
					:id => 1234,
					:tasksToRemove => "[]",
					:peopleToRemove => "[]",
				:peopleToAdd => "[]" }

				@request.headers["Accept"] = "application/json"
				put :update, h

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(403)
			end

			it "raises error on not parseable id arrays" do
				r = true, @project_a
				allow(Project).to receive(:update).and_return( r)

				@request.headers["Accept"] = "application/json"
				put :update, id: 1234

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(422)
			end
		end

		describe "#destroy" do
			it "returns url to project list" do
				expect(Project).to receive(:find_).and_return( @project)

				@request.headers["Accept"] = "application/json"
				delete :destroy, id: 0

				url = controller.url_for( projects_path)
				body = JSON.parse(response.body)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(200)
			end

			it "checks if project exists" do
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
