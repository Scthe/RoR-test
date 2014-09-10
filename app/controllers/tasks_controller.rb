class TasksController < ApplicationController

	# TODO add comments as inner resource

	def index
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list

		t = ProjectsController.stub_task( @user)
		@tasks = [t,t,t,t]
	end

	def show
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list

		@task = ProjectsController.stub_task( @user)
		@can_edit = true
	end

end
