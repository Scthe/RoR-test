class ProjectsController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => :create

	def index
		@user = ApplicationHelper::stub_user
		@task_count = 5
		@tasks_list

		p = ApplicationHelper::stub_project @user
		@projects = [p,p,p]

		render layout: true
	end

	def show
		@user = ApplicationHelper::stub_user
		@task_count = 5

		@project = ApplicationHelper::stub_project @user
		@can_edit = true

		render layout: true
	end

	def edit
		@user = ApplicationHelper::stub_user
		@task_count = 5
		@tasks_list

		@project = ApplicationHelper::stub_project @user
		@can_edit = true

		render layout: true
	end

	def new
		@user = ApplicationHelper::stub_user
		@task_count = 5
		@tasks_list

		@project = Project.new

		render layout: true
	end

	#
	#forms
	def create
		# p params[:project]
		respond_to do |format|
			format.json { render json: { :msg => 'seems ok' }.to_json}
		end
	end

	def update
		respond_to do |format|
			format.json { render json: { :msg => 'update !' }.to_json}
		end
	end

	def destroy
		# TODO this should not be json..
		respond_to do |format|
			format.json { render json: { :msg => 'destroy !' }.to_json}
		end
	end

end
