class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def index
		# TODO use jade
		# TODO add languages using some gem
		@user = ApplicationController.stub_user
		@task_count = 5
		render layout: true
	end

	def settings
		@user = ApplicationController.stub_user
		@task_count = 5
		render layout: true
	end

	def logout
		redirect_to "/"
	end

	def self.stub_user
		# TODO move getting user to separate module
		User.new.tap do |u|
			u.id = 1
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
