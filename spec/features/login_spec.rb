require 'rails_helper'

RSpec.describe "login process", :type => :feature do

	it "allows me to register", :js => true do
		# TODO why this test can be executed only once ?

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

	# it "signs me in" do
	# end

end
