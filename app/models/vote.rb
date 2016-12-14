class Vote < ActiveRecord::Base
  validates :question_id, presence: true
  validates :is_plus, inclusion: { in: [true, false] }
  belongs_to :user
  belongs_to :question
  belongs_to :answer
end
