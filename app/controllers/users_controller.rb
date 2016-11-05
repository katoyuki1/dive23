class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id)
    @ansers = Answer.where(user_id: @user.id)
  end
end
