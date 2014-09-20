class Project < ActiveRecord::Base

	belongs_to :user
	has_many :tasks
	has_many :users, :through => :project_person
	has_many :project_person

	validates :name, uniqueness: true, presence: true, length: { maximum: 50 }, format: { with: /\A\w+\Z/, message: "Name contains invalid characters" }
	validates :complete, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

	def self.projects_for_user( user)
		pip = ProjectPerson.where("user_id = ?", user.id)
		pip.map { |e| e.project }
	end

	def self.find_( project_id, user)
		raise ActiveRecord::RecordNotFound unless Project.can_be_viewed_by( project_id, user)
		find(project_id)
	end

	def self.can_be_viewed_by( project_id, user)
		ProjectPerson.exists?( { :user_id => user.id, :project_id => project_id})
	end

end
