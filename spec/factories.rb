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
end