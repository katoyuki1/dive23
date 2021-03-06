class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
  	@current_user_id = current_user.id
    @question = Question.find(params[:question_id])
    @vote_result = params[:vote_result]

    if params[:answer_id].present?
      @answer = Answer.find(params[:answer_id])
      @vote = Vote.new(user_id: @current_user_id, question_id: @question.id, answer_id: @answer.id, is_plus: @vote_result)
      respond_to do |format|
        if @answer.user_id == @current_user_id
          format.html { redirect_to question_path(@question), notice: '自分の回答には投票できません' }
        elsif @vote.save
          if @vote_result == "true"
            format.html { redirect_to question_path(@question), notice: '回答に投票（+1）をしました' }
          else
            format.html { redirect_to question_path(@question), notice: '回答に投票（-1）をしました' }
          end
        end
      end
    else
      @vote = Vote.new(user_id: @current_user_id, question_id: @question.id, answer_id: nil, is_plus: @vote_result)
      respond_to do |format|
        #binding.pry
        if @question.user_id == @current_user_id
          format.html { redirect_to question_path(@question), notice: '自分の質問には投票できません' }
        elsif @vote.save
          if @vote_result == "true"
            format.html { redirect_to question_path(@question), notice: '質問に投票（+1）をしました' }
          else
            format.html { redirect_to question_path(@question), notice: '質問に投票（-1）をしました' }
          end
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
