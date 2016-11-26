FactoryGirl.define do
  factory :answer do
    sequence(:content) { |i| "content#{i}" }
  end
end