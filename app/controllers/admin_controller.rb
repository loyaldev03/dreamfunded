class AdminController < ApplicationController

  def portfolio_admin
    if current_user == nil || current_user.authority < User.Authority[:Admin]
      redirect_to url_for(:controller => 'home', :action => 'unauthorized')
    end
    @user = User.find(params[:id])
    @investments = @user.investments
  end
  #move to admin
  def remove_investment
    investment = Investment.find(params[:id])
    investment.destroy
    redirect_to url_for(:action => 'write')
  end

  def write
    if current_user == nil || current_user.authority < User.Authority[:Admin]
      redirect_to url_for(:controller => 'home', :action => 'unauthorized')
    end
    @current_user = current_user
    @Authority = User.Authority
    @users = User.all.order(:created_at)
    @new = News.new
  end

  def promote
    user_login = params[:user]
    @user = User.find_by(email: user_login)
    if @user.authority != 4
      @user.update_column(:authority, @user.authority+1)
    end
    redirect_to(:action => :write)
  end


  def demote
    user_login = params[:user]
    @user = User.find_by(email: user_login)
    if @user.authority != 1
      @user.update_column(:authority, @user.authority-1)
    end
    redirect_to(:action => :write)
  end


  def delete
    user_login = params[:user]
    @user = User.find_by(email: user_login)
    @user.destroy
    redirect_to(:action => :write)
  end

  def admin
    @users = User.where(authority: 2)
  end


  def companies
    @companies = Company.where(accredited: true)
  end

end
