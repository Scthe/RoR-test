class ProjectsController < ApplicationController

	# In case of 'not [:id] provided just add field :id to the object'

	def index
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list

		p = ProjectsController.stub_project @user
		@projects = [p,p,p]

		render layout: true
	end

	def show
		@user = ApplicationController.stub_user
		@task_count = 5

		@project = ProjectsController.stub_project @user
		@can_edit = true

		render layout: true
	end

	def edit
		@user = ApplicationController.stub_user
		@task_count = 5
		@tasks_list

		@project = ProjectsController.stub_project @user
		@can_edit = true

		render layout: true
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
			p.complete = 33
			p.description = 'Null desc !'
			p.created_by_id = user

			t = ProjectsController.stub_task( user, p)
			p.tasks = [t,t,t,t]

			p.project_person = (0...4).to_a.map { |e| ProjectsController.stub_project_person( user, p)  }
		end
	end

	def self.stub_task( user, p=nil)
		p ||= ProjectsController.stub_project user

		Task.new.tap do |t|
			t.id = 1
			t.project_id = p
			t.person_responsible = user
			t.title = 'Task 1'
			t.task_type = 1
			# t.deadline: 2014-09-07
			t.description = 'MyText'
			t.created_by = user
			# t.files = []
		end
	end

	def self.stub_project_person( user, p)
		p.users = [] if p.users.nil?
		p.users << user

		ProjectPerson.new.tap do |pp|
			pp.user = user
			pp.project = p
			pp.role = 1
		end
	end
end
