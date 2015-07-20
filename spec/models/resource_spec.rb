require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe "validations" do
    subject { build(:resource) }

    it { should validate_presence_of(:name) }
    it { should allow_value(nil).for(:suggested_url) } # as can't allow blank on presence of matcher
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically') }
  end

  describe "associations" do
    it { should belong_to(:organisation) }
  end

  describe "should generate new friendly id" do

    subject(:resource) { create(:resource)}

    context "changing slug" do
      it "should generate new slug if title changed" do
        resource.name = "new title"
        expect(resource.should_generate_new_friendly_id?).to be true
      end

      it "should generate new slug if suggested url changed" do
        resource.suggested_url = "new url"
        expect(resource.should_generate_new_friendly_id?).to be true
      end
    end

    context "not changing slug" do
      it "should not generate new slug" do
        expect(resource.should_generate_new_friendly_id?).to be false
      end
    end
  end

end
