require 'rails_helper'

RSpec.describe TaskComment, :type => :model do

	before(:each) do
		@comment1 = build(:task_comment_a)
		@comment2 = build(:task_comment_b)
	end


	context "validation" do
		it "text should be proper length" do
			expect(@comment1.valid?).to be true

			@comment1.text = "a" * 140
			expect(@comment1.valid?).to be true

			@comment1.text = "a" * 141
			expect(@comment1.valid?).to be false
		end
	end

end
