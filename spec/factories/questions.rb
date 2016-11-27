FactoryGirl.define do
  # factory :question do
  #   sequence(:title) { |i| "title#{i}" }
  #   sequence(:content) { |i| "content#{i}" }
  # end

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