class Project < ActiveRecord::Base

	belongs_to :user
	has_many :tasks
	has_many :users, :through => :project_person
	has_many :project_person

	validates :name, uniqueness: true, presence: true, length: { maximum: 50 }, format: { with: /\A\w+\Z/, message: "Name contains invalid characters" }
	validates :complete, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

end
