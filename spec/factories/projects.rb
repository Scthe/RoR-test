FactoryGirl.define do

	factory :project_a, class: Project do
		name 			"ProjectA"
		complete 		50
		description 	"Null desc !"
		association :created_by_id, factory: :user_a
	end

	factory :project_b, class: Project do
		name 			"ProjectB"
		complete 		75
		description 	"Lorem !"
		association :created_by_id, factory: :user_b
	end
end
