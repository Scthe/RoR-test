FactoryGirl.define do

	factory :task_a, class: Task do
		title 		"Task 1"
		description "MyText"
		task_type 	1
		deadline 	DateTime.now
		association :project_id, factory: :project_a
		association :person_responsible_id, factory: :user_a
		association :created_by_id, factory: :user_a
	end

	factory :task_b, class: Task do
		title 		"Task 2"
		description "None ?"
		task_type 	3
		deadline 	DateTime.now
		association :project_id, factory: :project_b
		# association :person_responsible_id, factory: :user_a,
		association :created_by_id, factory: :user_a
	end
end
