class SignUpForm

	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	validates :username, presence: true
	validates :email, presence: true
	validates :password, presence: true
	validates :password2, presence: true

	attr_accessor :username, :email, :password, :password2

	def initialize(attributes = {})
		attributes.each do |name, value|
			send("#{name}=", value)
		end
	end

	def persisted?
		false
	end

end
