class FavoritesController < ApplicationController
before_action :authenticate_user!

  def create
  	@user_id = current_user.id
  	@question = Question.find(params[:question_id])
  	@favorite = Favorite.new(question_id: @question.id, user_id: @user_id)

  	respond_to do |format|
      if @favorite.save
        format.html { redirect_to question_path(@question), notice: 'お気に入りに追加しました' }
      end
    end
  end

  def destroy
  	@favorite = Favorite.find(params[:id])
  	@question = Question.find(params[:question_id])

  	respond_to do |format|
  	  if @favorite.destroy
        format.html { redirect_to question_path(@question), notice: 'お気に入りから削除しました' }
      end
    end
  end
end