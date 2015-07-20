require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  describe "validations" do
    it { should validate_presence_of(:resource) }
    it { should validate_presence_of(:category) }
  end

  describe "associations" do
    it { should belong_to(:resource) }
    it { should belong_to(:category) }
  end
end
