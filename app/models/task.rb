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
	has_many :comments, :class_name => "TaskComment"
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
end
