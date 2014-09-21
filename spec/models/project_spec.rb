require 'rails_helper'

RSpec.describe Project, :type => :model do

	before(:each) do
		@project = build(:project_a)
	end


	context "validation" do

		it "default fixture should pass" do
			expect(@project.valid?).to be true
		end

		it "should have proper name" do
			@project.name = ""
			expect(@project.valid?).to be false

			@project.name = nil
			expect(@project.valid?).to be false

			@project.name = "Aasd!!!"
			expect(@project.valid?).to be false

			@project.name = "aaaaaBBBBBaaaaaBBBBBaaaaaBBBBBaaaaaBBBBBaaaaaBBBBBa"
			expect(@project.valid?).to be false
		end

		it "complete status should be limited to [0, 100]" do
			@project.complete = 0
			expect(@project.valid?).to be true

			@project.complete = 100
			expect(@project.valid?).to be true

			@project.complete = -1
			expect(@project.valid?).to be false

			@project.complete = 101
			expect(@project.valid?).to be false
		end
	end

end
