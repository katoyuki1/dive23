class Vote < ActiveRecord::Base
  validates :question_id, presence: true
  validates :is_plus, presence: true
  belongs_to :user
  belongs_to :question
  belongs_to :answer
end
