require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    @user = build(:user)
  end

  context "validation" do
    it "correct user should be valid" do
      expect(@user.valid?).to be true
    end
  end
end
