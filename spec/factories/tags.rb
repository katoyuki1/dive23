FactoryGirl.define do
  factory :tag, :class => ActsAsTaggableOn::Tag do |f|
    f.sequence(:name) { |n| "titre#{n}" }
  end
end
# FactoryGirl.define do
#   factory :post do
#     trait :poetry do
#       after(:create) { |post| post.update_attributes(tag_list: 'poetry') }
#     end
#   end
# end
#
# FactoryGirl.define do
#   factory :tag do |f|
#   # Add any properties to make a valid Framework instance here, i.e. if you have
#   # validates_presence_of :name on the Framework model ...
#     f.name 'Test Name'
#   end
# end
