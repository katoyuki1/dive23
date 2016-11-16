class User < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :questions, through: :favorites
  has_many :votes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  def favorite?(question)
    self.favorites.find_by(question_id: question.id)
  end

  def vote_plus_question?(question)
    self.votes.find_by(question_id: question.id, answer_id: nil, is_plus: true)
  end

  def vote_minus_question?(question)
    self.votes.find_by(question_id: question.id, answer_id: nil, is_plus: false)
  end

  def vote_question_counts(question)
    vote_plus = Vote.where(question_id: question.id, answer_id: nil, is_plus: true).count
    vote_minus = Vote.where(question_id: question.id, answer_id: nil, is_plus: false).count
    vote_count = vote_plus + (-1)*vote_minus
    if vote_count.blank?
      vote_count = 0
    end
    return vote_count
  end

  def vote_plus_answer?(question, answer)
    self.votes.find_by(question_id: question.id, answer_id: answer.id, is_plus: true)
  end

  def vote_minus_answer?(question, answer)
    self.votes.find_by(question_id: question.id, answer_id: answer.id, is_plus: false)
  end

  def vote_answer_counts(question, answer)
    vote_plus = Vote.where(question_id: question.id, answer_id: answer.id, is_plus: true).count
    vote_minus = Vote.where(question_id: question.id, answer_id: answer.id, is_plus: false).count
    vote_count = vote_plus + (-1)*vote_minus
    if vote_count.blank?
      vote_count = 0
    end
    return vote_count
  end
end
