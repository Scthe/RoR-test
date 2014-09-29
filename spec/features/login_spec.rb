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
end
