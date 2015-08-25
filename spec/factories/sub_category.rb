FactoryGirl.define do
  factory :sub_category do
    category
    sequence(:name) {|n| "Service #{n}" }

    display true
  end
end