require 'rails_helper'

describe Question do
  # タイトルと内容があれば有効な状態であること
  it "is valid with title and content" do
    question = Question.new(title: 'foo', content: 'bar')
    expect(question).to be_valid
  end

  #タイトルがなければ無効であること
  it "is invalid without a title" do
    question = Question.new(title: nil, content: 'bar')
    expect(question).not_to be_valid
  end

  #内容がなければ無効であること
  it "is invalid without a content" do
    question = Question.new(title: nil, content: 'bar')
    expect(question).not_to be_valid
  end
end