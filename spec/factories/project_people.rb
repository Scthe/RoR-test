require "projectPerson"

FactoryGirl.define do

  factory :person_in_project_a, class: ProjectPerson do
		role 		0
		association :user_id, factory: :user_a
		association :project_id, factory: :project_a
	end

	factory :person_in_project_b, class: ProjectPerson do
		role 		0
		association :user_id, factory: :user_b
		association :project_id, factory: :project_a
	end
end
