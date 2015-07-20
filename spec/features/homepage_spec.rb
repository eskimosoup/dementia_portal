require 'rails_helper'

RSpec.feature "User visits the home page", type: :feature do
  before do
    create(:site_setting_name)
    @categories = create_list(:category, 4)
  end

  scenario "home page content exists" do
    visit root_path
    expect(page).to have_title("Dementia Portal")
    expect(page).to have_css(".home-category", count: 4)
    expect(page).to have_css("form.search-form")
    expect(page).to have_field("Keyword", with: "Enter search terms", type: "text")
    expect(page).to have_field("Keyword", with: "Enter search terms", type: "text")
    expect(page).to have_button("Search")
  end
end
