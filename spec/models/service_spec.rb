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

end
