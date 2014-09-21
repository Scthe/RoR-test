FactoryGirl.define do

  sequence :username do |n|
    "User#{n}"
  end

  factory :user_a, class: User do
    username
    firstname   "George"
    lastname    "Washington"
    email       "gw@gov.org"
    password    "pass111"
    is_active   true
    birthdate   DateTime.now
    gender      0
  end

  factory :user_b, class: User do
    username
    firstname   "Abraham"
    lastname    "Lincoln"
    email       "al@gov.org"
    password    "pass111"
    is_active   true
    birthdate   DateTime.now
    gender      0
  end

end
