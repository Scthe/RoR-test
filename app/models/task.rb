class Task < ActiveRecord::Base
	# TODO color the horizontal bar above content

	BUG 		= { :value => 0, :display_name => 'Bug' }
	IMPROVEMENT = { :value => 1, :display_name => 'Improvement' }
	NEW_FEATURE = { :value => 2, :display_name => 'New Feature' }
	OTHER 		= { :value => 3, :display_name => 'Other' }
	TASK_TYPES_L = [ BUG, IMPROVEMENT, NEW_FEATURE, OTHER ]
	TASK_TYPES = TASK_TYPES_L.map{ |e| e[:value] }

	# TASK_STATUS:
	# ('O','Open'),
	# ('P','In Progress'),
	# ('R','Resolved'),
	# ('C','Closed'),
	# ('D','Duplicate'),
	# ('X','Cannot Reproduce'),


	belongs_to :project
	belongs_to :person_responsible, :class_name => "User"
	belongs_to :created_by, :class_name => "User"
	has_many :comments, :class_name => "TaskComment", dependent: :destroy
	# http://stackoverflow.com/questions/14867981/how-do-i-add-migration-with-multiple-references-to-the-same-model-in-one-table

	validates :title, presence: true, length: { minimum: 3, maximum: 50}
	validates :task_type, inclusion: { in: TASK_TYPES}
	validates :deadline, presence: false
	validates :description, allow_blank: true, length: { minimum: 2}

	# TODO: validate rest of fields
	# add_reference :tasks, :project, references: :projects, index: true
	# add_reference :tasks, :person_responsible, references: :users, index: true
	# add_reference :tasks, :created_by, references: :users, index: true

	def task_type_obj
		TASK_TYPES_L.select { |e| e[:value] == self.task_type }.first
	end

	def self.find_( task_id, user)
		task = find(task_id)
		raise ActiveRecord::RecordNotFound unless task.send( :can_be_viewed_by, user) # TODO send ?!
		task
	end

	def self.create(params, user)
		t = Task.new( clean_params(params))
		t[:created_by_id] = user.id
		return t.save, t
	end

	def self.update( id, params, user)
		t = Task.find_( id, user)
		return t.update( clean_params_edit(params)), t
	end

	private
	def can_be_viewed_by( user)
		Project.can_be_viewed_by( self.project.id, user)
	end

	def self.clean_params(params)
		params.permit( :title, :task_type, :deadline, :description, :project_id, :person_responsible_id)
	end

	def self.clean_params_edit(params)
		params.permit( :title, :task_type, :deadline, :description, :person_responsible_id)
	end

end
