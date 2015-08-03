FactoryGirl.define do
  factory :article do
    sequence(:title) {|n| "my-nice-title-#{n}" }
    sequence(:suggested_url) {|n| "my-url-#{n}" }
    content "My content"
    date { Date.today }

    trait :displayed do
      display true
    end

    trait :not_displayed do
      display false
    end

    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end

    factory :displayed_article, traits: [:displayed]
    factory :not_displayed_article, traits: [:not_displayed]
    factory :displayed_article_with_image, traits: [:displayed, :with_image]
  end
end