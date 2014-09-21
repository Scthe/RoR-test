FactoryGirl.define do

  factory :user do # alt: factory :admin, class: User do
    username    "User1"
    firstname   "John"
    lastname    "Smith"
    gender      1
    email       "a.smith@gmail.com"
    password    "pass111"
  end

end
