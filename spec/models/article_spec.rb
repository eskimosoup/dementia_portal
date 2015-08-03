require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations", :validation do
    subject { build(:article) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:content) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically') }
  end

  describe "associations", :association do
    it { should have_many(:article_categories).dependent(:destroy) }
    it { should have_many(:categories).through(:article_categories) }
  end

  describe "scopes" do
    context "displayed scope" do
      it "should not find an article that is not displayed" do
        article = create(:article, display: false)
        expect(Article.displayed).not_to include(article)
      end

      it "should not find an article that is displayed" do
        article = create(:article)
        expect(Article.displayed).to include(article)
      end
    end

    context "active scope" do
      it "should not find an article that is not displayed" do
        article = create(:article, display: false)
        expect(Article.active).not_to include(article)
      end

      it "should find a displayed article with a date in the past" do
        article = create(:article)
        expect(Article.active).to include(article)
      end

      it "should not find an article in the future" do
        article = create(:article, date: Date.today + 1.day)
        expect(Article.active).not_to include(article)
      end
    end

    context "category scope" do
      let!(:categories) { create_list(:category, 4) }
      subject(:article) { create(:article, categories: categories.take(2)) }

      it "should find a article assigned to a category" do
        first_category_id = categories.first.id
        expect(Article.categories(first_category_id)).to include(article)
      end

      it "should not find articles not assigned to category" do
        last_category_id = categories.last.id
        expect(Article.categories(last_category_id)).not_to include(article)
      end

      it "should be returned when passed a category it belongs to and one it does not" do
        category_ids = [categories.first.id, categories.last.id]
        expect(Article.categories(category_ids)).to include(article)
      end

      it "should ignore the scope if passed nil" do
        expect(Article.categories(nil)).to include(article)
      end
    end
  end
end
