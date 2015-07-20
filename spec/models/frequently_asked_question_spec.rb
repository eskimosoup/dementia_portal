require 'rails_helper'

RSpec.describe FrequentlyAskedQuestion, type: :model do
  describe "validations" do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer) }
  end

  describe "associations" do
    it { should have_many(:frequently_asked_question_categories).dependent(:destroy) }
    it { should have_many(:categories).through(:frequently_asked_question_categories) }
  end
end
