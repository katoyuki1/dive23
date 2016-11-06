class AnswersController < ApplicationController
before_action :set_answer, only: [:edit, :update, :destroy]

  def create
  	@answer = current_user.answers.build(answer_params)
    @question = @answer.question

    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(@question), notice: '回答を投稿しました。' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  	@answer.destroy

    respond_to do |format|
      format.html { redirect_to question_path(@answer.question), notice: '回答が削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:question_id, :content)
    end

     def set_answer
      @answer = Answer.find(params[:id])
    end
end
