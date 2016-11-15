class TagsController < ApplicationController
  def index
    @tags = Blog.tags_on(:tags)
  end
end
