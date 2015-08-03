require 'rails_helper'

RSpec.describe Service, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations", :association do
    it { should have_many(:resource_services).dependent(:destroy) }
    it { should have_many(:resources).through(:resource_services) }
  end

  describe "scopes" do
    context "displayed scope" do
      it "should not find a service that is not displayed" do
        service = create(:service, display: false)
        expect(Service.displayed).not_to include(service)
      end

      it "should not find a service that isdisplayed" do
        service = create(:service)
        expect(Service.displayed).to include(service)
      end
    end
  end

end
