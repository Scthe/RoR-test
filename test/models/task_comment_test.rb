require 'test_helper'

class TaskCommentTest < ActiveSupport::TestCase

	def setup
		@comment1 = task_comments(:task_comment_a)
		@comment2 = task_comments(:task_comment_b)
	end

	test "text should be proper length" do
		assert @comment1.valid?

		@comment1.text = "a" * 140
		assert @comment1.valid?

		@comment1.text = "a" * 141
		assert_not @comment1.valid?
	end

end
