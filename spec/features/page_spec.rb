require 'rails_helper'

RSpec.feature "User visits a page", type: :feature do
  before do
    @page = Page.create(title: "The title", content: "The content") 
  end

  scenario "page content exists" do
    visit page_path(@page)
    expect(page).to have_css(".content")
  end
end
