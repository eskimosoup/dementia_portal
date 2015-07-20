require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do

  describe "validations" do
    it { should validate_presence_of(:article) }
    it { should validate_presence_of(:category) }
  end

  describe "associations" do
    it { should belong_to(:article) }
    it { should belong_to(:category) }
  end

end
