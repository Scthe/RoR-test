require 'rails_helper'

RSpec.describe Task, :type => :model do

	before(:each) do
		@project = build(:project_a)
		@project.id = 5
	end


	context "validation" do

		it "default fixture should pass" do
			expect(build(:task_a).valid?).to be true
			expect(build(:task_b).valid?).to be true
		end

		it "has correct title" do
			expect(build(:task_a, title:  "a").valid?).to be false
			expect(build(:task_a, title:  nil).valid?).to be false
			expect(build(:task_a, title:  "a" * 50).valid?).to be true
			expect(build(:task_a, title:  "a" * 51).valid?).to be false
		end

		it "has correct type" do
			Task::TASK_TYPES.each do |t|
				expect(build(:task_a, task_type:  t).valid?).to be true
			end

			expect(build(:task_a, task_type: -1).valid?).to be false
			expect(build(:task_a, task_type:  4).valid?).to be false
		end
	end

	it "retrieves correct task from database" do
		user = double member_of?: true
		task = create(:task_a, project: @project)
		id = task.id

		t = Task.find_(id, user)

		expect(t.title).to eq( task.title)
		expect(t.id).to eq( task.id)
	end

	it "checks if user can view task" do
		user = double member_of?: false
		task = create(:task_a, project: @project)
		id = task.id

		expect { Task.find_(id, user)}.to  raise_error( ActiveRecord::RecordNotFound)
	end

	# expect {
	# post :create, :service_id => service, :cdb_group => group_params, :button => "save", :format => "js"
	# }.to_not change(Group, :count)

end
