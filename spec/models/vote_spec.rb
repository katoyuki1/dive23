require 'rails_helper'

describe Vote do
  it "is valid with question_id and is_plus" do
    vote = Vote.new(question_id: 4, is_plus: true)
    expect(vote).to be_valid
  end

  it "is invalid without a question_id" do
    vote = Vote.new(question_id: nil, is_plus: true)
    expect(vote).not_to be_valid
  end

  it "is invalid without a is_plus" do
    vote = Vote.new(question_id: 2)
    expect(vote).not_to be_valid
  end

end
