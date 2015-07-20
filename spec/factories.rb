FactoryGirl.define do
  factory :site_setting, class: Optimadmin::SiteSetting do
    environment "test"
    trait :name do
      key 'Name'
      value 'Dementia Portal'
    end

    trait :email do
      key 'Email'
      value 'support@optimised.today'
    end
    factory :site_setting_name, traits: [:name]
    factory :site_setting_email, traits: [:email]
  end

  factory :category do
    sequence(:title) {|n| "my-nice-title-#{n}" }
    sequence(:suggested_url) {|n| "my-url-#{n}" }
    display true
    display_on_home true

    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :category_with_image, traits: [:with_image]
  end

  factory :article do
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

    factory :displayed_article, traits: [:displayed]
    factory :not_displayed_article, traits: [:not_displayed]
    factory :displayed_article_with_image, traits: [:displayed, :with_image]
  end

  factory :organisation do
    sequence(:name)  {|n| "organisation-name-#{n}" }
    address "some address"
    postcode "HU1 1NQ"
    phone "01987 654321"
    sequence(:email) {|n| "email#{n}@example.org"}
    website "www.google.co.uk"

    trait :charity do
      organisation_type "Charity"
    end

    trait :hull_city_council do
      organisation_type "Hull City Council"
    end

    trait :private_company do
      organisation_type "Private Company"
    end

    trait :displayed do
      display true
    end

    trait :not_displayed do
      display false
    end

    factory :displayed_organisation, traits: [:displayed]
    factory :not_displayed_organisation, traits: [:not_displayed]
    factory :displayed_charity_organisation, traits: [:displayed, :charity]
    factory :displayed_hull_city_council_organisation, traits: [:displayed, :hull_city_council]
    factory :displayed_private_company_organisation, traits: [:displayed, :private_company]
  end

  factory :resource do
    sequence(:name)  {|n| "resource-name-#{n}" }
    summary "resource summary"
    description "resource description"
    url "www.google.co.uk"
  end

end
