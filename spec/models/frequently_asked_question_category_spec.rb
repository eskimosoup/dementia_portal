require 'rails_helper'

RSpec.describe FrequentlyAskedQuestionCategory, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:frequently_asked_question) }
    it { should validate_presence_of(:category) }
  end

  describe "associations", :association do
    it { should belong_to(:frequently_asked_question) }
    it { should belong_to(:category) }
  end
end
