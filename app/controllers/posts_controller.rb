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
        redirect_to find_redirect(@post.page)
      else
        render :new
        render json: @post.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
      if @post.update(post_params)
        redirect_to find_redirect(@post.page)
      else
        render :edit
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    post = @post
    @post.destroy
    redirect_to find_redirect(post.page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def find_redirect(page)
      if page == 'about_us'
        return about_path
      elsif page == 'faq'
        return faq_path
      elsif page == 'basics'
        return education_path
      elsif page == 'terms'
        return education_path
      elsif page == 'tips'
        return education_tips_path
      elsif page == 'taxes'
        return education_taxes_path
      elsif page == 'investor-qa'
        return investorqa_path
      elsif page == 'employee-qa'
        return employeeqa_path
      elsif page == 'market_trends'
        return market_trends_path
      elsif page == 'how_works'
        return '/how_it_works'
      elsif page == 'jobs_act'
        return jobs_act_path
      elsif page == 'fund_raising_guide'
        return fund_raising_guide_path
      else
        return root
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :title, :source, :page, :position)
    end
end
