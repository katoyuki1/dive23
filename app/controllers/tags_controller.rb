class TagsController < ApplicationController
  def index
    @tags = Question.tags_on(:tags)
  end

  private
  def question_params
    params.require(:tag).permit(:title, :content, :tag_list, :name)
  end
end
