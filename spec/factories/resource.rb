FactoryGirl.define do
  factory :resource do
    sequence(:name)  {|n| "resource-name-#{n}" }
    summary "resource summary"
    description "resource description"
    url "www.google.co.uk"
    postcode "HU1 1NQ"
    display true
  end
end