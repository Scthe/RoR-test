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
	end

	def edit
		
	end

end
