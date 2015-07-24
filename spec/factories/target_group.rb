FactoryGirl.define do
  factory :target_group do
    sequence(:name) {|n| "Target Group #{n}" }

    display true
  end
end