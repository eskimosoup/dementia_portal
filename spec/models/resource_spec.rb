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
    it { should have_many(:resource_categories).dependent(:destroy) }
    it { should have_many(:categories).through(:resource_categories) }
    it { should have_many(:resource_target_groups).dependent(:destroy) }
    it { should have_many(:target_groups).through(:resource_target_groups) }
    it { should have_many(:resource_services).dependent(:destroy) }
    it { should have_many(:services).through(:resource_services) }
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

  describe "searching via scopes" do
    context "category scope" do
      let!(:categories) { create_list(:category, 4) }
      subject(:resource) { create(:resource, categories: categories.take(2)) }

      it "should find a resource assigned to a category" do
        first_category_id = categories.first.id
        expect(Resource.categories(first_category_id)).to eq([resource])
      end

      it "should not find resources not assigned to category" do
        last_category_id = categories.last.id
        expect(Resource.categories(last_category_id)).to eq([])
      end

      it "should be returned when passed a category it belongs to and one it does not" do
        category_ids = [categories.first.id, categories.last.id]
        expect(Resource.categories(category_ids)).to eq([resource])
      end

      it "should ignore the scope if passed nil" do
        expect(Resource.categories(nil)).to eq([resource])
      end
    end

    context "target group scope" do
      let!(:target_groups) { create_list(:target_group, 4) }
      subject(:resource) { create(:resource, target_groups: target_groups.take(2)) }

      it "should find a resource assigned to a target_group" do
        first_target_group_id = target_groups.first.id
        expect(Resource.target_groups(first_target_group_id)).to eq([resource])
      end

      it "should not find resources not assigned to target_group" do
        last_target_group_id = target_groups.last.id
        expect(Resource.target_groups(last_target_group_id)).to eq([])
      end

      it "should be returned when passed a target_group it belongs to and one it does not" do
        target_group_ids = [target_groups.first.id, target_groups.last.id]
        expect(Resource.target_groups(target_group_ids)).to eq([resource])
      end

      it "should ignore the scope if passed nil" do
        expect(Resource.target_groups(nil)).to eq([resource])
      end
    end

    context "target group scope" do
      let!(:services) { create_list(:service, 4) }
      subject(:resource) { create(:resource, services: services.take(2)) }

      it "should find a resource assigned to a service" do
        first_service_id = services.first.id
        expect(Resource.services(first_service_id)).to eq([resource])
      end

      it "should not find resources not assigned to service" do
        last_service_id = services.last.id
        expect(Resource.services(last_service_id)).to eq([])
      end

      it "should be returned when passed a service it belongs to and one it does not" do
        service_ids = [services.first.id, services.last.id]
        expect(Resource.services(service_ids)).to eq([resource])
      end

      it "should ignore the scope if passed nil" do
        expect(Resource.services(nil)).to eq([resource])
      end
    end

  end

end
