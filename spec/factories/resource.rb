FactoryGirl.define do
  factory :resource do
    sequence(:name)  {|n| "resource-name-#{n}" }
    summary "resource summary"
    description "resource description"
    url "www.google.co.uk"
  end
end