FactoryGirl.define do
  factory :category do
    sequence(:title) {|n| "Category #{n}" }

    display true
    display_on_home true

    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :category_with_image, traits: [:with_image]
  end
end