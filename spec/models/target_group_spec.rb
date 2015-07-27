require 'rails_helper'

RSpec.describe TargetGroup, type: :model do
  describe "validations", :validation do
    subject { build(:target_group) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should allow_value(nil).for(:suggested_url) } # as can't allow blank on presence of matcher
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically') }
  end

  describe "associations", :association do
    it { should have_many(:resource_target_groups).dependent(:destroy) }
    it { should have_many(:resources).through(:resource_target_groups) }
  end

  describe "should generate new friendly id" do

    subject(:target_group) { create(:target_group) }

    context "changing slug" do
      it "should generate new slug if name changed" do
        target_group.name = "new title"
        expect(target_group.should_generate_new_friendly_id?).to be true
      end

      it "should generate new slug if suggested url changed" do
        target_group.suggested_url = "new url"
        expect(target_group.should_generate_new_friendly_id?).to be true
      end
    end

    context "not changing slug" do
      it "should not generate new slug" do
        expect(target_group.should_generate_new_friendly_id?).to be false
      end
    end
  end
end
