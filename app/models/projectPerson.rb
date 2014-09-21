class ProjectPerson < ActiveRecord::Base
	self.table_name = "projectPerson"

	ROLE_USER = { :value => 0, :display_name => 'User' }
	ROLE_ADMIN= { :value => 1, :display_name => 'Admin' }
	ROLES = [ ROLE_USER[:value], ROLE_ADMIN[:value] ]

	belongs_to :project
	belongs_to :user
	validates :role, inclusion: { in: ROLES }

end
