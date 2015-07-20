require 'rails_helper'

RSpec.describe Organisation, type: :model do

  describe "validations" do
    subject { build(:organisation) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:postcode) }
    it { should validate_presence_of(:organisation_type) }
    it { should validate_inclusion_of(:organisation_type).in_array(Organisation::ORGANISATION_TYPES) }
  end

  describe "associations" do
    it { should have_many(:resources).dependent(:nullify) }
  end
end
