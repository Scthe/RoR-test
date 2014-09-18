class TasksController < ApplicationController

	# TODO add comments as inner resource

	def index
		@user = ApplicationHelper::stub_user
		@task_count = 5

		t = ApplicationHelper::stub_task( @user)
		@tasks = [t,t,t,t]
	end

	def show
		@user = ApplicationHelper::stub_user
		@task_count = 5

		@task = ApplicationHelper::stub_task( @user)
		@can_edit = true
		@canAddComment = true
	end

	def edit
		@user = ApplicationHelper::stub_user
		@task_count = 5

		@task = ApplicationHelper::stub_task( @user)
	end

	def new
		@user = ApplicationHelper::stub_user
		@task_count = 5

		@project = ApplicationHelper::stub_project @user
		@task = Task.new

		render layout: true
	end

	#
	# forms
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

	def add_comment
		respond_to do |format|
			format.json { render json: { :msg => 'comment add !' }.to_json}
		end
	end

end
