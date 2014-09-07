require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

	def setup
		@project = projects(:project_a)
	end

	test "default fixture should pass" do
		assert @project.valid?
	end

	test "should have proper name" do
		@project.name = "Aasd!!!"
		assert_not @project.valid?

		@project.name = "aaaaaBBBBBaaaaaBBBBBaaaaaBBBBBaaaaaBBBBBaaaaaBBBBBa"
		assert_not @project.valid?
	end

	test "complete status should be limited to [0, 100]" do
		@project.complete = 0
		assert @project.valid?

		@project.complete = 100
		assert @project.valid?

		@project.complete = -1
		assert_not @project.valid?

		@project.complete = 101
		assert_not @project.valid?
	end

end
