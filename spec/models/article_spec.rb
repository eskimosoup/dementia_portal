require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations", :validation do
    subject { build(:article) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:content) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically') }
  end

  describe "associations", :association do
    it { should have_many(:article_categories).dependent(:destroy) }
    it { should have_many(:categories).through(:article_categories) }
  end
end
