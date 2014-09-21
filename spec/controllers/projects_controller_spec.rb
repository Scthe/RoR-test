require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

	describe "smoke tests" do

		it "should get index" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("index")
			expect(response).to render_template("layouts/application")
		end

		it "should get show" do
			get :show, id: 0
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/show")
			expect(response).to render_template("layouts/application")
		end

		it "should get edit" do
			get :edit, id: 0
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/edit")
			expect(response).to render_template("layouts/application")
		end

		it "should get new" do
			get :new
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("projects/new")
			expect(response).to render_template("layouts/application")
		end
	end

end
