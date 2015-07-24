require 'rails_helper'

RSpec.describe ResourceTargetGroup, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:resource) }
    it { should validate_presence_of(:target_group) }
  end

  describe "associations", :association do
    it { should belong_to(:resource) }
    it { should belong_to(:target_group) }
  end
end
