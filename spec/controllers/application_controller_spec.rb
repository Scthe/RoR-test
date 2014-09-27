require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

	login_user

	describe "smoke tests" do

		it "should get index" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)

			expect(response).to render_template("index")
			expect(response).to render_template("layouts/application")

			expect(assigns(:user)).to be_truthy
		end

	end
end
