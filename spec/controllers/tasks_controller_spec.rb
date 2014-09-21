require 'rails_helper'


RSpec.describe TasksController, :type => :controller do

	describe "smoke tests" do

		it "should get index" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("index")
			expect(response).to render_template("layouts/application")
		end

		it "should get show" do
			get :show, id: 1
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("tasks/show")
			expect(response).to render_template("layouts/application")
		end

		it "should get edit" do
			get :edit, id: 1
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("tasks/edit")
			expect(response).to render_template("layouts/application")
		end

		it "should get new" do
			get :new
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("tasks/new")
			expect(response).to render_template("layouts/application")
		end
	end

end
