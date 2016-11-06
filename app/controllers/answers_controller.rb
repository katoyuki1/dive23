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
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path(@answer.question), notice: '回答内容が更新されました。' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
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
