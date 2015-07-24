require 'rails_helper'

RSpec.describe TargetGroup, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations", :association do
    it { should have_many(:resource_target_groups).dependent(:destroy) }
    it { should have_many(:resources).through(:resource_target_groups) }
  end
end
