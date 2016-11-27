require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

  describe 'Post #create' do
    before do
      @user = create(:user)
      @question = create(:question)
      @favorite = attributes_for(:favorite)
      @favorite = create(:favorite)
    end
    it 'リクエストは302 リダイレクトとなること' do
      post :create, favorite: @favorite, question_id: @favorite.question_id
      expect(response.status).to eq 302
    end
    it 'データベースに新しいユーザーが登録されること' do
      expect{
        post :create, favorite: @favorite, question_id: @favorite.question_id
      }.to change(Favorite, :count).by(1)
    end
    it 'question_pathにリダイレクトすること' do
      post :create, favorite: @favorite, question_id: @favorite.question_id
      expect(response).to redirect_to question_path(assigns(:favorite).question_id)
    end
  end

  describe 'Delete #destroy' do
    before do
      @user = create(:user)
      @question = create(:question)
      @favorite = create(:favorite)
    end
    it 'リクエストは302 リダイレクトとなること' do
      delete :destroy, question_id: @favorite.question_id, id: @favorite.id
      expect(response.status).to eq 302
    end
    it 'データベースから要求されたユーザーが削除されること' do
      expect{
        delete :destroy, question_id: @favorite.question_id, id: @favorite.id
      }.to change(Favorite,:count).by(-1)
    end
    it 'users#indexにリダイレクトされること'do
      delete :destroy, question_id: @favorite.question_id, id: @favorite.id
      expect(response).to redirect_to question_path(assigns(:favorite).question_id)
    end
  end

end
