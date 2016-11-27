FactoryGirl.define do
  factory :question do
    sequence(:title) { |i| "title#{i}" }
    sequence(:content) { |i| "content#{i}" }
  end
  factory :answer do
    sequence(:content) { |i| "content#{i}" }
  end
end