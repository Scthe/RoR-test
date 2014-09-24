class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter do |c|
		# TODO handle better f.e. require_login :index, :show etc. Use separate module in /lib

		@user = User.find(c.session[:user]) unless c.session[:user].nil?
		@user ||= User.find(0)
		# TODO skip this for api calls
		@task_list = @user.tasks_to_do
		@task_count = @task_list.length

		@data_page_type = :dashboard
	end

	def index
		# TODO root => login page
		# TODO heroku
		# 
		# TODO integration tests
		# TODO task create - should have some better reference to project ( use url)
		# TODO partial views
		# TODO add comments as inner resource for task
		# 
		# TODO check CSRF tokens with REST api
		# TODO use jade
		# TODO add languages using some gem
		
	end

	def settings
	end

	def logout
		redirect_to "/"
	end

	def self.set_page_type( t)
		# TODO move to separat module
		allowed = [:dashboard, :projects, :tasks]
		before_filter do |c|
			@data_page_type = t if allowed.include? t
		end
	end

=begin

http://stackoverflow.com/questions/3992659/in-rails-what-exactly-do-helper-and-helper-method-do

In case of 'not [:id] provided just add field :id to the object'


def create
  @user = User.new(params[:user])
  respond_to do |format|
    if @user.save
      format.html { redirect_to @user, notice: 'User was successfully created.' }
      format.js   {}
      format.json { render json: @user, status: :created, location: @user }
    else
      format.html { render action: "new" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end


=end

end
