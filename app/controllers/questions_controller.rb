class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_question_tags_to_gon, only: [:edit]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = params[:tag].present? ? Question.tagged_with(params[:tag]) :Question.all
    @questions = @questions.includes(:tags)
    @questions_total = Question.count
    @tags = ActsAsTaggableOn::Tag.most_used(20)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = @question.answers.build
    @answers = @question.answers
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: '質問が投稿されました' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: '質問内容が更新されました' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: '質問が削除されました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :content, :tag_list)
    end

    def set_question_tags_to_gon
      gon.question_tags = @question.tag_list
    end

    def correct_user
      @question = Question.find(params[:id])
      unless @question.user_id == current_user.id
        redirect_to questions_path, alert: "他人の投稿は変更・削除出来ません"
      end
    end
end
