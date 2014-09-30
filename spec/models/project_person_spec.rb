require 'rails_helper'

RSpec.describe ProjectPerson, :type => :model do

	before(:each) do
		@pp = build(:person_in_project_a)
	end


	context "validation" do
		it "has correct role" do
			ProjectPerson::ROLES.each do |t|
				@pp.role = t
				expect(@pp.valid?).to be true
			end

			@pp.role = -1
			expect(@pp.valid?).to be false

			@pp.role = 4
			expect(@pp.valid?).to be false
		end
	end
end
