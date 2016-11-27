FactoryGirl.define do
  factory :favorite do
    user_id 1
    question_id 1 
  end
  factory :user do
    id 1
    name "foo"
    email "barbar@example.com" 
    password "abcdeag"
  end
end