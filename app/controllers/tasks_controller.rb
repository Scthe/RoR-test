class TasksController < ApplicationController

	def index
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list

		t = ProjectsController.stub_task( @user)
		@tasks = [t,t,t,t]
	end
end
