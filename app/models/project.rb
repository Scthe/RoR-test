class Project < ActiveRecord::Base

	belongs_to :user
	has_many :tasks
	has_many :users, :through => :project_person
	has_many :project_person

	validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 50 }, format: { with: /\A\w+\Z/, message: "Name contains invalid characters" }
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

	def self.create(params, user)
		pr = Project.new( clean_params(params))
		begin
			Project.transaction do
				# params[:created_by_id] = user.id
				if pr.save!
					# if pr.valid?
					# pr.id = 1
					# add creator as admin !
					ProjectPerson.create!(:project_id => pr.id, :user_id => user.id, :role => 0)
					# ProjectPerson.new(:project_id => pr.id, :user_id => user.id)
					return true, pr
				end
			end
		rescue ActiveRecord::RecordInvalid=>e
		end
		return false, pr
	end

	private
	def self.clean_params(params)
		params.permit( :name, :complete, :description)
	end
end
