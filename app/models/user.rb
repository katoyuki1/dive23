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
    self.votes.find_by(question_id: question.id, is_plus: true)
  end

  def vote_minus_question?(question)
    self.votes.find_by(question_id: question.id, is_plus: false)
  end
end
