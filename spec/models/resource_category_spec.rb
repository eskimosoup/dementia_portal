require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  describe "validations", :validation do
    it { should validate_presence_of(:resource) }
    it { should validate_presence_of(:category) }
  end

  describe "associations", :association do
    it { should belong_to(:resource) }
    it { should belong_to(:category) }
  end
end
