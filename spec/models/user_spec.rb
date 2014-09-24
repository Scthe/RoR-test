require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    @user = build(:user_a)
  end


  context "validation" do

    it "correct user should be valid" do
      expect(@user.valid?).to be true
    end

    it "should not be valid with incorrect username" do
      u = @user

      u.username = nil
      expect(u.valid?).to be false

      u.username = "Aa"
      expect(u.valid?).to be false

      u.username = "UserAbc$"
      expect(u.valid?).to be false
    end

    it "should allow blank first and lastname" do
      u = @user
      u.lastname = nil
      u.firstname = nil
      expect(u.valid?).to be true
    end

    it "should not be valid with incorrect first and lastname" do
      u = @user
      u.lastname = "a"
      expect(u.valid?).to be false

      u = @user
      u.firstname = "a"
      expect(u.valid?).to be false

      u = @user
      u.lastname = "Aaa9"
      expect(u.valid?).to be false

      u = @user
      u.firstname = "Aaa9"
      expect(u.valid?).to be false
    end

    it "gender should be valid only in 2 cases ( oh, wow !)" do
      test = {
        User::MALE[:value] => true,
        User::FEMALE[:value] => true,
        -1 => false,
        2 => false
      }
      test.each do |k,v|
        u = @user
        u.gender = k
        expect(u.valid?).to be v
      end
    end

    # TODO validate email & password
  end

  it "should preety print name correctly" do
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
