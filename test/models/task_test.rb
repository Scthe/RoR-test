require 'test_helper'

class TaskTest < ActiveSupport::TestCase

	def setup
		@task  = tasks(:task_a)
		@task2 = tasks(:task_b)
	end

	test "default fixture should pass" do
		assert @task.valid?
		assert @task2.valid?
	end

	test "should have correct title" do
		@task.title = "a"
		assert_not @task.valid?

		@task.title = "a"
		assert_not @task.valid?

		@task.title = "a" * 50
		assert @task.valid?

		@task.title = "a" * 51
		assert_not @task.valid?
	end

	test "should have correct type" do
		Task::TASK_TYPES.each do |t|
			@task.task_type = t
			assert @task.valid?
		end

		@task.task_type = -1
		assert_not @task.valid?

		@task.task_type = 4
		assert_not @task.valid?
	end


end
