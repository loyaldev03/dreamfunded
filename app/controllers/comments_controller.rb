 class CommentsController < ApplicationController

  def create
    respond_to do |format|
      @comment = Comment.new(comment_params)
      if @comment.save
        format.js   {}
        format.html   {redirect_to :back}
        format.json { render :show, status: :created, location: @comment }
        #ContactMailer.new_comment(@comment).deliver
        #ContactMailer.new_comment_company_owner(@comment).deliver
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def remove_comment
    if params[:id] != nil
      @comment = Comment.find(params[:id])
      if (@comment != nil)
        @comment.destroy
      end
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :company_id, :parent_id, :created_at, :updated_at)
  end
end
