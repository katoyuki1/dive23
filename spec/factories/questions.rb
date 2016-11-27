FactoryGirl.define do
  factory :question do
    id 1
    title "foo"
    content "bar" 
  end
  factory :question_2, class: Question do
    id 2
    title "foo"
    content "bar" 
  end
end