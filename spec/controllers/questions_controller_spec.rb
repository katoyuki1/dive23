require 'rails_helper'

describe QuestionsController do
  describe 'Get #new' do
    before do
      get :new
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '@questionに新しいquestionを割り当てること' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    it ':newテンプレートを表示すること' do
      expect(response).to render_template :new
    end
  end

  describe 'Get #index' do
    before do
      @q1 = create(:question, title: "1st question", content: "how's ruby")
      @q2 = create(:question, title: "2nd question", content: "how's rails")
      get :index
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '@questionsに全てのquestionを割り当てること' do
      expect(assigns(:questions)).to match_array([@q1,@q2])
    end
    it ':indexテンプレートを表示すること' do
      expect(response).to render_template :index
    end
  end

  describe 'Get #edit' do
    before do
      @question = create(:question)
      get :edit, id: @question.id
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '@questionに要求されたquestionを割り当てること' do
      expect(assigns(:question)).to eq @question
    end
    it ':editテンプレートを表示すること' do
      expect(response).to render_template :edit
    end
  end

  describe 'Get #show' do
    before do
      @question = create(:question)
    end
    context '要求されたquestionが存在する場合' do
      before do
        get :show, id: @question.id
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it '@userに要求されたquestionを割り当てること' do
        expect(assigns(:question)).to eq @question
      end
      it ':showテンプレートを表示すること' do
        expect(response).to render_template :show
      end
    end
    context '要求されたquestionが存在しない場合' do
      it 'リクエストはRecordNotFoundとなること' do
        expect{
          get :show, id: "foo"
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'Post #create' do
    before do
      @question = attributes_for(:question)
    end
    it 'リクエストは302 リダイレクトとなること' do
      post :create, question: @question
      expect(response.status).to eq 302
    end
    it 'データベースに新しいユーザーが登録されること' do
      expect{
        post :create, question: @question
      }.to change(Question, :count).by(1)
    end
    it 'rootにリダイレクトすること' do
      post :create, question: @question
      expect(response).to redirect_to question_path(assigns(:question).id)
    end
  end

  describe 'Patch #update' do
    before do
      @question = create(:question)
      @original_title = @question.title
      patch :update, id: @question.id, question: attributes_for(:question, title: "foobar")
    end
    it 'リクエストは302 リダイレクトとなること' do
      expect(response.status).to eq 302
    end
    it 'データベースのユーザーが更新されること' do
      @question.reload
      expect(@question.title).to eq "foobar"
    end
    it 'questions#showにリダイレクトすること' do
      expect(response).to redirect_to question_path(assigns(:question).id)
    end
  end

  describe 'Delete #destroy' do
    before do
      @question = create(:question)
    end
    it 'リクエストは302 リダイレクトとなること' do
      delete :destroy, id: @question.id
      expect(response.status).to eq 302
    end
    it 'データベースから要求されたユーザーが削除されること' do
      expect{
        delete :destroy, id: @question.id
      }.to change(Question,:count).by(-1)
    end
    it 'users#indexにリダイレクトされること'do
      delete :destroy, id: @question.id
      expect(response).to redirect_to questions_path
    end
  end
end