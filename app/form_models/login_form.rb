class LoginForm

	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	validates :username, presence: true
	validates :password, presence: true

	attr_accessor :username, :password

	def initialize(attributes = {})
		attributes.each do |name, value|
			send("#{name}=", value)
		end
	end

	def persisted?
		false
	end

end
