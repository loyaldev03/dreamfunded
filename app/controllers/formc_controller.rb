class FormcController < ApplicationController
  before_action :authenticate_user!


  def general
    @general_info = GeneralInfo.new
  end

  def people
  end

  def terms
  end

  def disclosures
  end

  def financials
  end

  def submit
  end

private


end
