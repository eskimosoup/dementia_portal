require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of(:title) }

  context "a standard category" do
    subject(:category) { create(:category)}

    it "should generate new slug if title changed" do
      category.title = "new title"
      expect(category).to be_should_generate_new_friendly_id
    end

    it "should generate new slug if suggested url changed" do
      category.suggested_url = "new url"
      expect(category).to be_should_generate_new_friendly_id
    end

  end
end
