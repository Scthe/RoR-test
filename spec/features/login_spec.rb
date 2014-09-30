require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "login process", :type => :feature do

	it "allows me to register", :js => true do
		visit '/'

		find('#sign-up').click

		within find('#register-dialog') do
			fill_in 'sign_up_form[username]', :with => 'aaaa3'
			fill_in 'sign_up_form[email]', :with => 'a3@gmail.com'
			fill_in 'sign_up_form[password]', :with => 'aaaaa'
			fill_in 'sign_up_form[password_confirmation]', :with => 'aaaaa'

			d = find '#register'
			d.click
		end

		expect(page).to have_content 'Dashboard'
	end

	it "signs me in", :js => true do
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

	it "requires being logged in before accessing sites" do
		skip_urls = [ '/', '/assets', '/users/[spce0-9]+.*']
		skip_urls = skip_urls.map{ |e| Regexp.new "^#{e}$" }

		routes = Rails.application.routes.routes

		routes.each do |route|
			r = route.path.spec.to_s
			s = r.gsub( /\(?\.:format\)?/, '') # remove :format
			s.gsub!( /:id/, 1.to_s) # add :id if needed

			if route.verb.to_s =~ /GET/ && skip_urls.find{ |e| s =~ e} .nil?
				# p "#{route.verb} #{s}"
				visit s
				expect(current_path).to eq('/')
			end
		end
	end

	context "when logged in" do
		it "is not necessary", :js => true do
			user = create( :user_a)
			login_as(user, scope: :user)

			visit '/'

			expect(page).to have_content 'Dashboard'
		end
	end

	it "allows me to logout", :js => true do
		user = create( :user_a)
		login_as(user, scope: :user)

		visit '/dashboard'
		expect(page).to have_content 'Dashboard'

		find('#navigation-bar-logout').click
		expect(page).to have_content 'Sign up now'
	end

=begin TODO why this test fails with SQLite3::BusyException ?
	it "checks if both passwords are the same", :js => true do
		visit '/'

		find('#sign-up').click
		register_dialog = find('#register-dialog')
		within register_dialog do
			fill_in 'user[username]', :with => 'aaaa3'
			fill_in 'user[email]', :with => 'a3@gmail.com'
			fill_in 'user[password]', :with => 'aaaaa'
			fill_in 'user[password_confirmation]', :with => 'aaaab'

			d = find '#register'
			d.click
		end

		expect(page).to have_content 'Sign up now'
	end
=end
end
