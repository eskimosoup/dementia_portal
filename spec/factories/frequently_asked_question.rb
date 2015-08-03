FactoryGirl.define do
  factory :frequently_asked_question do
    sequence(:question)  {|n| "Question #{n}" }
    answer "blah"
    display true
  end
end