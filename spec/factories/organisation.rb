FactoryGirl.define do
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
end