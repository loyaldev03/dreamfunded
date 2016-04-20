class PressPostsController < ApplicationController

  def index
  end

  private

  def press_post_params
      params.require(:press_post).permit(:date, :name, :url, :source)
  end
end
