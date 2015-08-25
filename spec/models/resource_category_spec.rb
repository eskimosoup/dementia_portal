require 'rails_helper'

RSpec.describe ResourceSubCategory, type: :model do

  describe "validations", :validation do
    it { should validate_presence_of(:resource) }
    it { should validate_presence_of(:sub_category) }
  end

  describe "associations", :association do
    it { should belong_to(:resource) }
    it { should belong_to(:sub_category) }
  end
end
