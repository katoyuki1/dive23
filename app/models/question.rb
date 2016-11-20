class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :votes, dependent: :destroy
  acts_as_taggable

  def vote_question_counts
    vote_plus = Vote.where(question_id: self.id, answer_id: nil, is_plus: true).count
    vote_minus = Vote.where(question_id: self.id, answer_id: nil, is_plus: false).count
    vote_count = vote_plus + (-1)*vote_minus
    if vote_count.blank?
      vote_count = 0
    end
    return vote_count
  end
end
