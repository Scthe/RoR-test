class ProjectsController < ApplicationController
	
	def index
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list
		
		p = ProjectsController.stub_project @user
		@projects = [p,p,p]

		render layout: true
	end

	def show
		
	end

	def new
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list

		@project = Project.new

		render layout: true
	end

	#
	#forms
	def create
		
	end

	#
	#stubs

	def self.stub_project( user)
		# TODO move getting user to separate module
		Project.new.tap do |p|
			p.id = 1
			p.name = 'ProjectA'
			p.complete = 50
			p.description = 'Null desc !'
			p.created_by_id = user
		end
	end

end
