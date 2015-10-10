class NewsController < ApplicationController

#default page with news listed by most recent
  def index
  	@news = News.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  #to be a list much like index but with more control functionalities
  def manage

  end

  #create new using admin account
  def new
	if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
		redirect_to url_for(:controller => 'home', :action => 'unauthorized')
	end
   @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      redirect_to "/news"
    else
      @error_message = ""
      @news.errors.full_messages.each do |error|
        @error_message = @error_message + error + ". "
      end
      flash[:message] = @error_message
      redirect_to "/news/new"
    end
  end

  def edit
    @article = News.find(params[:id])
  end

  def update
    @article = News.find(params[:id])
    if @article.update(news_params)
      redirect_to "/new/full/#{@article.id}"
    else
      render :edit
    end
  end

  def full
    if params[:id] != nil
      @article = News.find(params[:id])
      render "/news/full"
    else
      redirect_to "/news"
    end
  end

  def remove_new
    if params[:id] != nil
        @article = News.find(params[:id])
        if (@article != nil)
          @article.destroy
        end
    end
      redirect_to "/news"
  end

  private
  def news_params
    params.require(:news).permit(:title, :image, :content, :source, :created_at, :updated_at )
  end

end
