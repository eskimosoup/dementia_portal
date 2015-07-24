require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "validations", :validation do
    subject { build(:contact) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:query) }
  end
end
