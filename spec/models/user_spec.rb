require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    @user = build(:user_a)
  end


  context "validation" do

    it "correct user should be valid" do
      expect(@user.valid?).to be true
    end

    it "has correct username" do
      expect(build(:user_a, username:   nil).valid?).to be false
      expect(build(:user_a, username:   "Aa").valid?).to be false
      expect(build(:user_a, username:   "User$Abc").valid?).to be false
    end

    it "is correct without first and lastname" do
      u = @user
      u.lastname = nil
      u.firstname = nil
      expect(u.valid?).to be true
    end

    it "has correct first and lastname" do
      expect(build(:user_a, lastname:      "a").valid?).to be false
      expect(build(:user_a, lastname:   "Aa9a").valid?).to be false
      expect(build(:user_a, firstname:     "a").valid?).to be false
      expect(build(:user_a, firstname:  "Aa9a").valid?).to be false
    end

    it "has correct gender" do
      test = {
        User::MALE[:value] => true,
        User::FEMALE[:value] => true,
        -1 => false,
        2 => false
      }
      test.each do |k,v|
        expect(build(:user_a, gender:  k).valid?).to be v
      end
    end

    it "does not require providing gender" do
      expect(build(:user_a, gender:  nil).valid?).to be true
    end

    # TODO validate email & password
    #
  end

  it "preety prints name correctly" do
    u = build(:user_a)
    expect(u.to_s).to eq("George Washington")

    u = build(:user_a)
    u.firstname = nil
    expect(u.to_s).to eq(u.username)

    u = build(:user_a)
    u.lastname = nil
    expect(u.to_s).to eq(u.username)

    u = build(:user_a)
    u.firstname = nil
    u.lastname = nil
    expect(u.to_s).to eq(u.username)
  end
end
