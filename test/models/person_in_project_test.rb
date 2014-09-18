require 'test_helper'

class PersonInProjectTest < ActiveSupport::TestCase

	def setup
		@pp  = projectPerson(:person_in_project_a)
	end

	test "should have correct role" do
		ProjectPerson::ROLES.each do |t|
			@pp.role = t
			assert @pp.valid?
		end

		@pp.role = -1
		assert_not @pp.valid?

		@pp.role = 4
		assert_not @pp.valid?
	end
end
