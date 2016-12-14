class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id)
    @answers = Answer.where(user_id: @user.id)
    @favorite_questions = @user.questions

    @contribution_point = contribution(@user)
  end

  def contribution(user)
    @point = 0
    @questions = Question.where(user_id: @user.id)
    @question_vote_table = @questions.joins(:votes).includes(:votes)
    @question_vote_table.each do |question|
      question.votes.each { |vote|
        if vote.is_plus == true
          @point += 1
        else
          @point -= 1
        end
      }
    end
    return @point
  end

end
