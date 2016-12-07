FactoryGirl.define do
  factory :vote_question, class: Vote do
    user_id 1
    question_id 1
    answer_id nil
    is_plus true
  end
  factory :vote_answer, class: Vote do
    id 2
    user_id 1
    question_id 3
    answer_id 4
    is_plus true
  end
end
