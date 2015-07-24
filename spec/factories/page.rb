FactoryGirl.define do
  factory :page do
    sequence(:title) {|n| "my-nice-title-#{n}" }
    sequence(:suggested_url) {|n| "my-url-#{n}" }
    content "My content"

    trait :displayed do
      display true
    end

    trait :not_displayed do
      display false
    end

    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end

    factory :displayed_page, traits: [:displayed]
    factory :not_displayed_page, traits: [:not_displayed]
    factory :displayed_page_with_image, traits: [:displayed, :with_image]
  end
end