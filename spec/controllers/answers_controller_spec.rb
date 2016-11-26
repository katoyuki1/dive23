require 'rails_helper'

describe AnswersController do
  describe 'Get #edit' do
    before do
      @question = create(:question)
      @answer = create(:answer)
      get :edit, {:question_id => @question.id, :id => @answer.id}
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '@questionに要求されたquestionを割り当てること' do
      expect(assigns(:answer)).to eq @answer
    end
    it ':editテンプレートを表示すること' do
      expect(response).to render_template :edit
    end
  end

  describe 'Post #create' do
    before do
      @question = create(:question)
      @answer = attributes_for(:answer)
    end
    it 'リクエストは302 リダイレクトとなること' do
      post :create, question_id: @question.id, 
        answer: {
          question_id: @question.id,
          content: "foo"
        }
      expect(response.status).to eq 302
    end
    it 'データベースに新しいユーザーが登録されること' do
      expect {
        post :create,
        question_id: @question.id,
        answer: {
          question_id: @question.id,
          content: "foo"
        }
      }.to change(Answer, :count).by(1)
    end
    it 'question_pathにリダイレクトすること' do
      post :create,
        question_id: @question.id,
        answer: {
          question_id: @question.id,
          content: "foo"
        }
      expect(response).to redirect_to question_path(assigns(:question).id)
    end
  end
end