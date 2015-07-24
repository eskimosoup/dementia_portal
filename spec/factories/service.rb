FactoryGirl.define do
  factory :service do
    sequence(:name) {|n| "Service #{n}" }

    display true
  end
end