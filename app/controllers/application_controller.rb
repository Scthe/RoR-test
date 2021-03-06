class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter      :authenticate_user!, :only => [ :index, :settings, :logout, :settings]

	before_filter do |c|
		unless current_user.nil?
			# TODO skip this for api calls
			@user = current_user
			@task_list = @user.tasks_to_do
			@task_count = @task_list.length
		end

		@data_page_type = :dashboard
	end

	def index # dashboard
	end

	def settings
	end

	def login
		return redirect_to dashboard_path if user_signed_in?

		# @login = LoginForm.new # TODO not used
		@sign_up = SignUpForm.new
		render layout: false
	end

	protected
	def self.set_page_type( t)
		# TODO move to separat module
		allowed = [:dashboard, :projects, :tasks]
		before_filter do |c|
			@data_page_type = t if allowed.include? t
		end
	end

	def authenticate_user!
		if user_signed_in?
			super
		else
			## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
			redirect_to login_path
		end
	end

	def after_sign_out_path_for(resource_or_scope)
		:login
	end

=begin

# TODO heroku & capistrano
# TODO force https
#
# TODO integration tests
# TODO task create - should have some better reference to project ( use url)
# TODO add comments as inner resource for task
# TODO code coverage
#
# TODO check CSRF tokens with REST api
# TODO use jade
# TODO add languages using some gem
# TODO global handlers: rescue_from ActiveRecord::RecordNotFound do |e|;error_response(message: e.message, status: 404);end

# scenarios:
# * login fail, refresh, login ok
# * register, log out, log in


cmds:
librarian-chef install
vagrant plugin install vagrant-omnibus
vagrant reload --provision
vagrant halt

bundle exec rspec spec
bundle exec spring
bundle exec spring binstub rspec
bundle exec spring rspec spec
bundle exec spring stop


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
