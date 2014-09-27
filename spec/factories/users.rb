FactoryGirl.define do

  sequence :username do |n|
    "User#{n}"
  end

  sequence :email do |n|
    "main#{n}@gov.org"
  end

  factory :user_a, class: User do
    username
    firstname   "George"
    lastname    "Washington"
    email
    password    "pass111"
    is_active   true
    birthdate   DateTime.now
    gender      0
  end

  factory :user_b, class: User do
    username
    firstname   "Abraham"
    lastname    "Lincoln"
    email
    password    "pass111"
    is_active   true
    birthdate   DateTime.now
    gender      0
  end

end
