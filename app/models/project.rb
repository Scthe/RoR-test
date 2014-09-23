class Project < ActiveRecord::Base

	belongs_to :user
	has_many :tasks, dependent: :destroy
	has_many :users, :through => :project_person
	has_many :project_person, dependent: :destroy

	validates :name, presence: true, length: { minimum: 3, maximum: 50 }, format: { with: /\A[A-Za-z0-9 -]+\Z/, message: "Name contains invalid characters" }
	validates :complete, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

	def self.find_( project_id, user)
		raise ActiveRecord::RecordNotFound unless user.member_of?( project_id)
		find(project_id)
	end

	def self.create(params, user)
		pr = Project.new( clean_params(params))
		begin
			Project.transaction do
				pr[:created_by_id] = user.id
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

	def self.update( id, params, tasks_to_remove, people_remove, people_to_add, user)
		# TODO check if admin
		begin
			Project.transaction do
				pr = find_(id, user)

				if pr.update!(clean_params(params))
					Task.where(:project_id => id, :id => tasks_to_remove).destroy_all
					ProjectPerson.where(:project_id => id, :id => people_remove).destroy_all
					# add people
					people_to_add.each do |person_id|
						ProjectPerson.create!(:project_id => pr.id, :user_id => person_id, :role => 0)
					end
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
