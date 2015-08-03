require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:title) }
  end

  describe "associations", :association do
    it { should have_many(:article_categories).dependent(:destroy) }
    it { should have_many(:articles).through(:article_categories) }
    it { should have_many(:resource_categories).dependent(:destroy) }
    it { should have_many(:resources).through(:resource_categories) }
    it { should have_many(:frequently_asked_question_categories).dependent(:destroy) }
    it { should have_many(:frequently_asked_questions).through(:frequently_asked_question_categories) }
  end

  describe "scopes" do
    context "displayed scope" do
      it "should not find a category that is not displayed" do
        category = create(:category, display: false)
        expect(Category.displayed).not_to include(category)
      end

      it "should not find a category that isdisplayed" do
        category = create(:category)
        expect(Category.displayed).to include(category)
      end
    end
  end

  describe "should generate new friendly id" do

    subject(:category) { create(:category)}

    context "changing slug" do
      it "should generate new slug if title changed" do
        category.title = "new title"
        expect(category.should_generate_new_friendly_id?).to be true
      end

      it "should generate new slug if suggested url changed" do
        category.suggested_url = "new url"
        expect(category.should_generate_new_friendly_id?).to be true
      end
    end

    context "not changing slug" do
      it "should not generate new slug" do
        expect(category.should_generate_new_friendly_id?).to be false
      end
    end
  end
end
