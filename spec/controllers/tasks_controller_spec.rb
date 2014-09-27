require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

	login_user

	before(:each) do
		user = double member_of?: true, id: 1, tasks_to_do: @tasks
		p = double users: [user]
		@task = double project: p, id: 1
	end

	describe "smoke tests" do

		it "should get index" do
			@tasks = [ build(:task_a), build(:task_b)]
			controller.current_user.tasks_to_do = @tasks

			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("index")
			expect(response).to render_template("layouts/application")

			expect(assigns(:task_list)).to eq(@tasks)
			expect(assigns(:task_count)).to eq(@tasks.length)
		end

		it "should get show" do
			allow(Task).to receive(:find_).and_return(@task)
			get :show, id: 1
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("tasks/show")
			expect(response).to render_template("layouts/application")
			expect(assigns(:task)).to eq(@task)
		end

		it "should get edit" do
			allow(Task).to receive(:find_).and_return(@task)
			get :edit, id: 1
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("tasks/edit")
			expect(response).to render_template("layouts/application")
			expect(assigns(:task)).to eq(@task)
		end

		it "should get new" do
			allow(Project).to receive(:find).and_return( build(:project_a))
			get :new
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("tasks/new")
			expect(response).to render_template("layouts/application")
			expect(assigns(:task)).to be_a_new(Task)
		end
	end

	context "fail to get task" do

		context "show" do
			it "should 403 if project not found" do
				expect(Task).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)
				get :show, id: 0
				expect(response).to have_http_status(403)
			end

			it "should 403 if user is not memeber of the project" do
				allow(controller.current_user).to receive(:member_of?).and_return( false)
				get :show, id: 0
				expect(response).to have_http_status(403)
			end
		end

		context "edit" do
			it "should 403 if task not found" do
				expect(Task).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)
				get :edit, id: 0
				expect(response).to have_http_status(403)
			end

			it "should 403 if user is not memeber of the project" do
				allow(controller.current_user).to receive(:member_of?).and_return( false)
				get :edit, id: 0
				expect(response).to have_http_status(403)
			end
		end
	end

	context "API" do

		describe "create" do
			it "should return created task" do
				task = build(:task_a, id: 1234)
				r = true, task
				expect(Task).to receive(:create).and_return( r)

				@request.headers["Accept"] = "application/json"
				post :create

				url = controller.url_for( task_path (task) )
				body = JSON.parse(response.body)

				expect(body["title"]).to eq(task.title)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(201)
			end

			it "should return list of errors if data is not ok" do
				l = { "a" => 1, "b" => 2}
				r = false, (double errors: l)
				expect(Task).to receive(:create).and_return( r)

				@request.headers["Accept"] = "application/json"
				post :create

				body = JSON.parse(response.body)
				expect(body).to match_array( l.keys)

				expect(response).to have_http_status(422)
			end
		end

		describe "update" do
			it "should return status ok for correct data" do
				task = build(:task_a, id: 1234)
				r = true, task
				expect(Task).to receive(:update).and_return( r)

				@request.headers["Accept"] = "application/json"
				put :update, id: 1234

				url = controller.url_for( task_path (task) )
				body = JSON.parse(response.body)

				expect(body["title"]).to eq(task.title)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(200)
			end

			it "should not update on incorrect data" do
				l = { "a" => 1, "b" => 2}
				r = false, (double errors: l)
				expect(Task).to receive(:update).and_return( r)

				@request.headers["Accept"] = "application/json"
				put :update, id: 1234

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy
				expect(body).to match_array( l.keys)

				expect(response).to have_http_status(422)
			end

			it "should not update not existing project" do
				expect(Task).to receive(:update).and_raise( ActiveRecord::RecordNotFound)

				@request.headers["Accept"] = "application/json"
				put :update, id: 1234

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(403)
			end
		end

		describe "destroy" do
			it "should return url to tasks list" do
				task = build(:task_a, id: 1234)
				expect(Task).to receive(:find_).and_return( task)

				@request.headers["Accept"] = "application/json"
				delete :destroy, id: 0

				url = controller.url_for( tasks_path)
				body = JSON.parse(response.body)
				expect(body["url"]).to eq(url)

				expect(response).to have_http_status(200)
			end

			it "should not delete project that does not exists" do
				expect(Task).to receive(:find_).and_raise( ActiveRecord::RecordNotFound)

				@request.headers["Accept"] = "application/json"
				delete :destroy, id: 0

				body = JSON.parse(response.body)
				expect(body.include? "url").to be_falsy

				expect(response).to have_http_status(422)
			end
		end

	end
end
