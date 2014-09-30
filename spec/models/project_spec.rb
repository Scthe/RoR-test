require 'rails_helper'

RSpec.describe Project, :type => :model do

	context "validation" do

		it "default fixture should pass" do
			expect(build(:project_a).valid?).to be true
		end

		it "has proper name" do
			expect(build(:project_a, name:   "").valid?).to be false
			expect(build(:project_a, name:  nil).valid?).to be false
			expect(build(:project_a, name:  "Aasd!!!").valid?).to be false
			expect(build(:project_a, name:  "a"*51).valid?).to be false
		end

		it "complete status limited to [0, 100]" do
			expect(build(:project_a, complete:   0).valid?).to be true
			expect(build(:project_a, complete: 100).valid?).to be true
			expect(build(:project_a, complete:  -1).valid?).to be false
			expect(build(:project_a, complete: 101).valid?).to be false
		end
	end

	it "retrieves correct project from database" do
		user = double member_of?: true
		p = create(:project_a)
		id = p.id

		t = Project.find_(id, user)

		expect(t.name).to eq( p.name)
		expect(t.id).to eq( p.id)
	end

	it "checks if user can view project" do
		user = double member_of?: false
		expect { Project.find_(5, user)}.to  raise_error( ActiveRecord::RecordNotFound)
	end

end
