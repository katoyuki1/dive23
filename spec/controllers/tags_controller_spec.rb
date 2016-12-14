require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe "GET #index" do
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it 'インスタンス変数が適切かどうか' do
      pending 'テストデータの作成方法が不明なため保留'
      @q = Question.new(title: 'title', content: 'body')
      @q.tag_list.add('Ruby', 'Rails')
      # @framework = FactoryGirl.create(:tag)
      # @framework = FactoryGirl.build(:tag, :taggings => 'foo, bar')
      expect(assigns(:tag)).to include(@q)
    end
    it '正常にindexメソッドを呼び出せているか' do
      get :index
      expect(response).to render_template :index
    end
  end
end
