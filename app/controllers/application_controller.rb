class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def index
		# render "hi !"
		@user = stub_user
		render layout: true
	end

	def stub_user
		# TODO move getting user to separate module
		User.new.tap do |u|
			u.username = 'Abra'
			u.firstname = 'Abraham'
			u.lastname = 'Lincoln'
			u.email = 'al@gov.org'
			u.password = 'MyString'
			u.is_active = true
			# u.birthdate: 2014-09-03
		end
	end
end
