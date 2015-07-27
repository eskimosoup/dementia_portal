require 'rails_helper'

RSpec.feature "Searching for resources", type: :feature do
  let!(:categories) { create_list(:category, 4) }

  scenario "visiting resources page" do
    visit resources_path
    expect(current_path).to eq(resources_path)

    expect(page).to have_css("form.resources-search-form")
    expect(page).to have_field("search_keyword", type: "text")
    expect(page).to have_button("Search")
    expect(page).to have_css(".category-check-box", count: categories.count)
  end

end
