require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "login process", :type => :feature do

	it "allows me to register", :js => true do
		visit '/'

		find('#sign-up').click
		register_dialog = find('#register-dialog')
		within register_dialog do
			fill_in 'user[username]', :with => 'aaaa3'
			fill_in 'user[email]', :with => 'a3@gmail.com'
			fill_in 'user[password]', :with => 'aaaaa'
			fill_in 'user[password_confirmation]', :with => 'aaaaa'

			d = find '#register'
			d.click
		end
		uri = URI.parse(current_url)

		expect(page).to have_content 'Dashboard'
	end

	it "signs me in", :js do
		visit '/'
		user = create(:user_a)

		within find('#login_form') do
			fill_in 'user[username]', with: user.username
			fill_in 'user[password]', with: user.password

			d = find '#login'
			d.click
		end
		expect(page).to have_content 'Dashboard'
	end

end
