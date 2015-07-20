require 'rails_helper'

RSpec.describe Service, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

end
