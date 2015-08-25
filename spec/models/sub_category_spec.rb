require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations", :association do
    it { should have_many(:resource_sub_categories).dependent(:destroy) }
    it { should have_many(:resources).through(:resource_sub_categories) }
  end

  describe "scopes" do
    context "displayed scope" do
      it "should not find a service that is not displayed" do
        sub_category = create(:sub_category, display: false)
        expect(SubCategory.displayed).not_to include(sub_category)
      end

      it "should not find a service that isdisplayed" do
        sub_category = create(:sub_category)
        expect(SubCategory.displayed).to include(sub_category)
      end
    end
  end

end
