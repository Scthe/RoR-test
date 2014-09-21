require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "correct user should be valid" do
    u = create_ok_user
    assert u.valid?
  end

  test "should not be valid with incorrect username" do
    u = create_ok_user

    u.username = nil
    assert_not u.valid?

    u.username = "Aa"
    assert_not u.valid?

    u.username = "UserAbc$"
    assert_not u.valid?
  end

  test "should allow blank first and lastname" do
    u = create_ok_user
    u.lastname = nil
    u.firstname = nil
    assert u.valid?
  end

  test "should not be valid with incorrect first and lastname" do
    u = create_ok_user
    u.lastname = "a"
    assert_not u.valid?

    u = create_ok_user
    u.firstname = "a"
    assert_not u.valid?

    u = create_ok_user
    u.lastname = "Aaa9"
    assert_not u.valid?

    u = create_ok_user
    u.firstname = "Aaa9"
    assert_not u.valid?
  end

  test "gender should be valid only in 2 cases ( oh, wow !)" do
    test = {
      User::MALE[:value] => true,
      User::FEMALE[:value] => true,
      -1 => false,
      2 => false
    }
    test.each do |k,v|
      u = create_ok_user
      u.gender = k
      assert ( u.valid? == v)
    end
  end

  # TODO validate email & password

 test "should preety print name correctly" do
    u = create_ok_user
    assert_equal "John Smith", u.to_s

    u = create_ok_user
    u.firstname = nil
    assert_equal "User1 Smith", u.to_s

    u = create_ok_user
    u.lastname = nil
    assert_equal "John", u.to_s

    u = create_ok_user
    u.firstname = nil
    u.lastname = nil
    assert_equal "User1", u.to_s
  end

  private
  def create_ok_user
    User.new.tap do |u|
      u.username = "User1"
      u.firstname = "John"
      u.lastname = "Smith"
      u.gender = 1
      u.email = "a.smith@gmail.com"
      u.password = "pass111"
    end
  end

end
