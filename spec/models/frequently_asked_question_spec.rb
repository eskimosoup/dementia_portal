require 'rails_helper'

RSpec.describe FrequentlyAskedQuestion, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer) }
  end

  describe "associations", :association do
    it { should have_many(:frequently_asked_question_categories).dependent(:destroy) }
    it { should have_many(:categories).through(:frequently_asked_question_categories) }
  end

  describe "scopes" do
    context "displayed scope" do
      it "should not find a faq that is not displayed" do
        faq = create(:frequently_asked_question, display: false)
        expect(FrequentlyAskedQuestion.displayed).not_to include(faq)
      end

      it "should not find a faq that isdisplayed" do
        faq = create(:frequently_asked_question)
        expect(FrequentlyAskedQuestion.displayed).to include(faq)
      end
    end

    context "category scope" do
      let!(:categories) { create_list(:category, 4) }
      subject(:faq) { create(:frequently_asked_question, categories: categories.take(2)) }

      it "should find a faq assigned to a category" do
        first_category_id = categories.first.id
        expect(FrequentlyAskedQuestion.categories(first_category_id)).to include(faq)
      end

      it "should not find faqs not assigned to category" do
        last_category_id = categories.last.id
        expect(FrequentlyAskedQuestion.categories(last_category_id)).not_to include(faq)
      end

      it "should be returned when passed a category it belongs to and one it does not" do
        category_ids = [categories.first.id, categories.last.id]
        expect(FrequentlyAskedQuestion.categories(category_ids)).to include(faq)
      end

      it "should ignore the scope if passed nil" do
        expect(FrequentlyAskedQuestion.categories(nil)).to include(faq)
      end
    end
  end
end
