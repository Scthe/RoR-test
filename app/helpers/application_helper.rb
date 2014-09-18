module ApplicationHelper

	def self.stub_user
		# TODO move getting user to separate module
		User.new.tap do |u|
			u.id = 1
			u.username = 'Abra'
			u.firstname = 'Abraham'
			u.lastname = 'Lincoln'
			u.email = 'al@gov.org'
			u.password = 'MyString'
			u.is_active = true
			# u.birthdate: 2014-09-03
		end
	end

	def self.stub_project( user)
		# TODO move getting user to separate module
		Project.new.tap do |p|
			p.id = 1
			p.name = 'ProjectA'
			p.complete = 33
			p.description = 'Null desc !'
			p.created_by_id = user

			t = ApplicationHelper::stub_task( user, p)
			p.tasks = [t,t,t,t]

			p.project_person = (0...4).to_a.map { |e| ApplicationHelper::stub_project_person( user, p)  }
		end
	end

	def self.stub_task( user, p=nil)
		p ||= ApplicationHelper::stub_project user

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
			t.created_at = DateTime.now

			t.comments = (0...4).to_a.map { |e| ApplicationHelper::stub_task_comment( t, user)  }
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

	def self.stub_task_comment( task, user)
		TaskComment.new.tap do |pp|
			pp.user = user
			pp.task = task
			pp.text = "Comment !"
			pp.created_at = DateTime.now
		end
	end

end
