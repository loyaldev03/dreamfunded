class NewsController < ApplicationController

#default page with news listed by most recent
  def index
  	@news = New.all
  end

  #to be a list much like index but with more control functionalities
  def manage

  end

  #create new using admin account
  def new
	if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
		redirect_to url_for(:controller => 'home', :action => 'unauthorized')
	end
  end

  def create #needs to add a date/time variable
  	if params[:file] != nil
  		uploaded_file = params[:file]
  		@file_name = uploaded_file.original_filename
  		directory = "app/assets/images" #need more folders later
  		path = File.join(directory, @file_name)
  		File.open(path, "wb") { |f| f.write(uploaded_file.read) }

  		@news_title = params[:title]
  		@content = params[:content][0]
  		flash[:file_upload] = "Image upload successful"
  		uploaded = News.new(:title => @news_title, :image_filename => @file_name, :content => @content)
  		uploaded.save
  		redirect_to "/news"
  	else
  		flash[:file_uploaded] = "Image is not valid"
  		redirect_to "/news/new"
  	end
  end

  def full
    if params[:id] != nil
      @article = New.find(params[:id])
      render "/news/full"
    else
      redirect_to "/news"
    end
  end

end
