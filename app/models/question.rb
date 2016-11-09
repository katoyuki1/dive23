class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  acts_as_taggable
end
