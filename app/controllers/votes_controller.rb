class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @vote_result = params[:vote_result]

    if params[:answer_id].present?
      @answer = Answer.find(params[:answer_id])
      @vote = Vote.new(user_id: current_user.id, question_id: @question.id, answer_id: @answer.id, is_plus: true)
    else
      @vote = Vote.new(user_id: current_user.id, question_id: @question.id, is_plus: @vote_result)
    end

    respond_to do |format|
      if @question.user_id == current_user.id
        format.html { redirect_to question_path(@question), notice: '自分の質問には投票できません' }
      elsif @vote.save
        if @vote_result == "true"
          format.html { redirect_to question_path(@question), notice: '投票（+1）をしました' }
        else
          format.html { redirect_to question_path(@question), notice: '投票（-1）をしました' }
        end
      end
    end
  end

  def destroy
  	@vote = Vote.find(params[:id])
  	@question = Question.find(params[:question_id])

  	respond_to do |format|
  	  if @vote.destroy
        format.html { redirect_to question_path(@question), notice: '投票をリセットしました' }
      end
    end
  end
end
