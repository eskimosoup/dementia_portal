require 'rails_helper'

RSpec.feature "Searching for resources", type: :feature do
  let!(:categories) { create_list(:category, 4) }
  let!(:target_groups) { create_list(:target_group, 4) }
  let!(:services) { create_list(:service, 4) }

  scenario "visiting resources page" do
    visit resources_path
    expect(current_path).to eq(resources_path)

    expect(page).to have_css("form.resources-search-form")
    expect(page).to have_field("resource_search_keywords", type: "text")
    expect(page).to have_button("Search")
    expect(page).to have_css(".category.check-box", count: categories.count)
    expect(page).to have_css(".target-group.check-box", count: target_groups.count)
    expect(page).to have_css(".service.check-box", count: services.count)
    expect(page).to have_field("resource_search_postcode", type: "text")
    expect(page).to have_select("resource_search_radius", options: ResourceSearch::RADIUS_OPTIONS.map(&:first))
  end

end
