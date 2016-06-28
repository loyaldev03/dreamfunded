class CommentsController < ApplicationController

  def create
    respond_to do |format|
      @comment = Comment.new(comment_params)
      if @comment.save
        format.js   {}
        format.html   {redirect_to :back}
        format.json { render :show, status: :created, location: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :company_id, :created_at, :updated_at)
  end
end
