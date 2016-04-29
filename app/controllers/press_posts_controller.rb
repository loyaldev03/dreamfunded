class PressPostsController < ApplicationController

  def index
    @press
  end

  def new
    @press_post = PressPost.new
  end

  private

  def press_post_params
      params.require(:press_post).permit(:date, :name, :url, :source)
  end
end
