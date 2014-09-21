FactoryGirl.define do
	
	factory :task_comment_a, class: TaskComment do
		text "comment 1"
		association :task_id, factory: :task_a
		association :user_id, factory: :user_a
	end

	factory :task_comment_b, class: TaskComment do
		text "MyString2"
		association :task_id, factory: :task_a
		association :user_id, factory: :user_b
	end
end
