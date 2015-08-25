require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe "validations", :validation do
    subject { build(:resource) }

    it { should validate_presence_of(:name) }
    it { should allow_value(nil).for(:suggested_url) } # as can't allow blank on presence of matcher
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically') }
  end

  describe "associations", :association do
    it { should belong_to(:organisation) }
    it { should have_many(:resource_sub_categories).dependent(:destroy) }
    it { should have_many(:sub_categories).through(:resource_sub_categories) }
    it { should have_many(:resource_target_groups).dependent(:destroy) }
    it { should have_many(:target_groups).through(:resource_target_groups) }
  end

  describe "delegations", :delegation do
    it { should delegate_method(:name).to(:organisation).with_prefix }
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

  describe "scopes" do
    context "displayed scope" do
      it "should not find a faq that is not displayed" do
        resource = create(:resource, display: false)
        expect(Resource.displayed).not_to include(resource)
      end

      it "should not find a faq that isdisplayed" do
        resource = create(:resource)
        expect(Resource.displayed).to include(resource)
      end
    end

    context "id not scope" do
      let!(:resources) { create_list(:resource, 2) }
      let(:first_resource) { resources.first }

      it "should not include the first resource when passed the first id" do
        expect(Resource.id_not(first_resource)).not_to include(first_resource)
      end

      it "should include the second resource when passed the first resource" do
        expect(Resource.id_not(resources.last)).to include(first_resource)
      end
    end

    context "category scope" do
      let!(:sub_categories) { create_list(:sub_category, 4) }
      subject(:resource) { create(:resource, sub_categories: sub_categories.take(2)) }

      it "should find a resource assigned to a category" do
        first_category_id = sub_categories.first.id
        expect(Resource.sub_categories(first_category_id)).to include(resource)
      end

      it "should not find resources not assigned to category" do
        last_category_id = sub_categories.last.id
        expect(Resource.sub_categories(last_category_id)).not_to include(resource)
      end

      it "should be returned when passed a category it belongs to and one it does not" do
        category_ids = [sub_categories.first.id, sub_categories.last.id]
        expect(Resource.sub_categories(category_ids)).to include(resource)
      end

      it "should ignore the scope if passed nil" do
        expect(Resource.sub_categories(nil)).to include(resource)
      end
    end

    context "target group scope" do
      let!(:target_groups) { create_list(:target_group, 4) }
      subject(:resource) { create(:resource, target_groups: target_groups.take(2)) }

      it "should find a resource assigned to a target_group" do
        first_target_group_id = target_groups.first.id
        expect(Resource.target_groups(first_target_group_id)).to include(resource)
      end

      it "should not find resources not assigned to target_group" do
        last_target_group_id = target_groups.last.id
        expect(Resource.target_groups(last_target_group_id)).not_to include(resource)
      end

      it "should be returned when passed a target_group it belongs to and one it does not" do
        target_group_ids = [target_groups.first.id, target_groups.last.id]
        expect(Resource.target_groups(target_group_ids)).to include(resource)
      end

      it "should ignore the scope if passed nil" do
        expect(Resource.target_groups(nil)).to include(resource)
      end
    end

    context "geocoder" do
      subject(:resource) { create(:resource) }
      it "should return the resource when searched using geocoder" do
        expect(Resource.near("HU1 1NQ", 20)).to include(resource)
      end
    end

  end

end
