class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def index
		# TODO use jade
		# TODO add languages using some gem
		@user = ApplicationHelper::stub_user
		@task_count = 5
		render layout: true
	end

	def settings
		@user = ApplicationHelper::stub_user
		@task_count = 5
		render layout: true
	end

	def logout
		redirect_to "/"
	end


=begin

TODO http://stackoverflow.com/questions/3992659/in-rails-what-exactly-do-helper-and-helper-method-do

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
