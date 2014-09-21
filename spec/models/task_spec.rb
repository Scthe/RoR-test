require 'rails_helper'

RSpec.describe Task, :type => :model do

	before(:each) do
		@task  = build(:task_a)
		@task2 = build(:task_b)
	end


	context "validation" do

		it "default fixture should pass" do
			expect(@task.valid?).to be true
			expect(@task2.valid?).to be true
		end

		it "should have correct title" do
			@task.title = "a"
			expect(@task.valid?).to be false

			@task.title = "a"
			expect(@task.valid?).to be false

			@task.title = "a" * 50
			expect(@task.valid?).to be true

			@task.title = "a" * 51
			expect(@task.valid?).to be false
		end

		it "should have correct type" do
			Task::TASK_TYPES.each do |t|
				@task.task_type = t
				expect(@task.valid?).to be true
			end

			@task.task_type = -1
			expect(@task.valid?).to be false

			@task.task_type = 4
			expect(@task.valid?).to be false
		end
	end
end
