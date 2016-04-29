class PressPostsController < ApplicationController

  def index
    @press_posts = PressPost.all
  end

  def new
    @press_post = PressPost.new
  end

  def create
    @press_post = PressPost.new(press_post_params)

      if @press_post.save
        redirect_to press_posts_path, notice: 'Member was successfully created.'
      else
        render :new
      end

  end

  private

  def press_post_params
      params.require(:press_post).permit(:date, :name, :url, :image, :quote)
  end
end
