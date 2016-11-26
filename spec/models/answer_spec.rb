require 'rails_helper'

describe Answer do
  # 内容があれば有効な状態であること
  it "is valid with a content" do
    answer = Answer.new(content: 'bar')
    expect(answer).to be_valid
  end

  # 内容がなければ無効であること
  it "is invalid without a content" do
    answer = Answer.new(content: nil)
    expect(answer).not_to be_valid
  end
end