# validates :username, :uniqueness => true
# validates :username, uniqueness: true

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable#, :validatable

	MALE 	= { :value => 0, :display_name => "Male"}
	FEMALE 	= { :value => 1, :display_name => "Female"}

	has_many :projects, :through => :project_persons
	has_many :project_persons
	has_many :tasks_to_do, :class_name => "Task", :foreign_key => "person_responsible_id"

	validates :username, uniqueness: true, presence: true, length: { minimum: 3}, format: { with: /\A[0-9A-Za-z_]+\Z/i, message: "letters/numbers !" }
	validates :firstname, allow_blank: true, length: { minimum: 2}, format: { with: /\A[A-Za-z_ ]+\Z/i, message: "letters !" }
	validates :lastname, allow_blank: true, length: { minimum: 2}, format: { with: /\A[A-Za-z_ ]+\Z/i, message: "letters !" }
	validates :gender, allow_blank: true,inclusion: { in: [ MALE[:value], FEMALE[:value] ]}
=begin
	validates :email, presence true, uniqueness true, length { minimum: 3}, email true
	validates :password, presence true,  length { minimum: 3}
	#t.boolean :is_active
    #t.date :birthdate
=end

	def to_s
		if firstname.nil? or lastname.nil? then username else firstname + " " + lastname end
	end

	def member_of?( project_id)
		ProjectPerson.exists?( { :user_id => self.id, :project_id => project_id})
	end
end
