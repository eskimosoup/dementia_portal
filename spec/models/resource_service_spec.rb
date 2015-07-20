require 'rails_helper'

RSpec.describe ResourceService, type: :model do
  describe "validations" do
    it { should validate_presence_of(:resource) }
    it { should validate_presence_of(:service) }
  end

  describe "associations" do
    it { should belong_to(:resource) }
    it { should belong_to(:service) }
  end
end
