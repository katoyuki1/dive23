require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  describe 'Vote #create' do
    before do
      @user = create(:user)
      @question = create(:question)
      @vote = create(:vote_question)
    end
    it 'リクエストは302 リダイレクトとなること' do
      post :create, question_id: @vote.question_id, vote_result: @vote.is_plus
      expect(response.status).to eq 302
    end
    it 'データベースに新しい投票が登録されること' do
      expect{
        post :create, question_id: @vote.question_id, vote_result: @vote.is_plus
      }.to change(Vote, :count).by(1)
    end
    it 'questions#showにリダイレクトすること' do
      post :create, question_id: @vote.question_id, vote_result: @vote.is_plus
      expect(response).to redirect_to question_path(@vote.question_id)
    end
  end

  describe 'Vote #destroy' do
    before do
      @user = create(:user)
      @question = create(:question)
      @vote = create(:vote_question)
    end
    it 'リクエストは302 リダイレクトとなること' do
      delete :destroy, id: @vote.id, question_id: @question.id
      expect(response.status).to eq 302
    end
    it 'データベースから要求されたユーザーが削除されること' do
      expect{
        delete :destroy, id: @vote.id, question_id: @question.id
      }.to change(Vote,:count).by(-1)
    end
    it 'question#indexにリダイレクトされること'do
      delete :destroy, id: @vote.id, question_id: @question.id
      expect(response).to redirect_to question_path(@question)
    end
  end
end
