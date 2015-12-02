class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @page = params[:page]
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @page = params[:page]
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
      if @post.save
        if @post.page == 'faq'
          redirect_to faq_path, notice: 'Post was successfully updated.'
        elsif @post.page == 'about_us'
          redirect_to about_path, notice: 'Post was successfully updated.'
        elsif @post.page == 'basics'
          redirect_to edication_basics_path
        elsif @post.page == 'terms'
          redirect_to education_terms_path
        elsif @post.page == 'tips'
          redirect_to education_tips_path
        else
          redirect_to @post, notice: 'Post was successfully updated.'
        end
      else
        render :new
        render json: @post.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

      if @post.update(post_params)
        if @post.page == 'faq'
          redirect_to faq_path, notice: 'Post was successfully updated.'
        elsif @post.page == 'about_us'
          redirect_to about_path, notice: 'Post was successfully updated.'
        elsif @post.page == 'basics'
          redirect_to edication_basics_path
        elsif @post.page == 'terms'
          redirect_to education_terms_path
        elsif @post.page == 'tips'
          redirect_to education_tips_path, notice: 'Post was successfully updated.'
        else
          redirect_to @post, notice: 'Post was successfully updated.'
        end


      else
        render :edit

      end

  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    post = @post
    @post.destroy
    if post.page == 'about_us'
      redirect_to about_path, notice: 'Post was successfully updated.'
    elsif @post.page == 'faq'
      redirect_to faq_path, notice: 'Post was successfully updated.'
    elsif @post.page == 'basics'
      redirect_to edication_basics_path
    elsif @post.page == 'terms'
      redirect_to education_terms_path
    elsif @post.page == 'tips'
      redirect_to education_tips_path, notice: 'Post was successfully updated.'
    else
      redirect_to root
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :title, :source, :page, :position)
    end
end
