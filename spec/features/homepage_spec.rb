require 'rails_helper'

RSpec.feature "Home Page", type: :feature do
  scenario "visiting the home page" do
    before do
      create(:site_setting_name)
    end

    let(:categories) { create_list(:categories, 4) }

    it "accesses the home page" do
      visit root_path
      expect(page).to have_title("Dementia Portal")
    end
  end
end
