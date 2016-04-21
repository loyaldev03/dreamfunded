class ContactMailer < ActionMailer::Base
  default from: "DreamFunded <info@dreamfunded.com>"


  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to DreamFunded")
  end

  def reset_email(user)
    @user = user
    mail(to: user.email, subject: "Reset Password Instructions")
  end

  def verify_email(user)
    @user = user
    mail(to: @user.email, subject: "Verify Email")
  end

  def contact_us_email(name, email, phone, message)
    @name = name
    @email= email
    @phone = phone
    @message = message
    mail(to: "info@dreamfunded.com", subject: 'Guest Contacted From DreamFunded website')
    # mail(to: "alexandr.larionov88@gmail.com", subject: 'Guest Contacted From DreamFunded website')
  end

  def liquidate_email(first_name, last_name, company, number_shares, shares_price, timeframe, email, phone, rofr_restrictions, financial_assistance, message)
    @first_name = first_name
    @last_name = last_name
    @email= email
    @phone = phone
    @company = company
    @number_shares = number_shares
    @shares_price = shares_price
    @timeframe = timeframe
    @rofr_restrictions = rofr_restrictions
    @financial_assistance = financial_assistance
    @message = message
    mail(to: ["info@dreamfunded.com", "rexford@dreamfunded.com"], subject: "Request to liquidate #{number_shares} shares of #{company} (#{timeframe} timeframe)")
    # mail(to: "alexandr.larionov88@gmail.com", subject: 'Request to liquidate shares')
  end

  def prospective_investment_email(first_name, last_name, email, phone, company, investment_amount, shares_price)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @company = company
    @investment_amount = investment_amount
    @shares_price = shares_price
    mail(to: "info@dreamfunded.com", subject: "Bid on #{company}: $#{shares_price}/share and Total Investment of #{investment_amount}")
  end

  def open_auction_email(first_name, last_name, email, phone, company, number_shares, shares_price)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @company = company
    @number_shares = number_shares
    @shares_price = shares_price
    User.where(authority: 2).each do |user|
      mail(to: user.email, subject: "Dreamfunded: new Auction for #{number_shares} shares of #{company}")
    end
  end

  def account_created(user)
    @name = user.last_name
    @email= user.email
    mail(to: "info@dreamfunded.com", subject: 'New Account Created')
  end

  def personal_hello(user)
    @name = user.first_name
    @email= user.email
    mail(to: @email, subject: 'Following up', from: 'Manny Fernandez <manny@dreamfunded.com>')
  end

  def reset_password_request(user)
    @name = user.last_name
    @email= user.email
    mail(to: "info@dreamfunded.com", subject: 'Password Reset Request')
  end

  def seller_account(seller, password)
    @seller = seller
    @password = password
    mail(to: @seller.email, subject: "DreamFunded Account Created")
  end

  def bid_created(seller, bid)
    @seller = seller
    @bid = bid
    mail(to: @seller.email, subject: 'A Bid Has Been Placed')
  end

  def bid_accepted(bid)
    user = User.find(bid.user_id)
    @bid = bid
    mail(to: user.email, subject: "Your Bid Has Been Accepted")
  end

  def bid_declined(bid)
    user = User.find(bid.user_id)
    @bid = bid
    mail(to: user.email, subject: "Bid was Declined")
  end

  def counter_offer(bid, price, number)
    @bid = bid
    @price = price
    @number= number
    @user = @bid.user
    mail(to: @bid.user.email, subject: "Counter Offer has been made for you bid on #{@bid.company.name}")
  end

  def seller_accepts_offer(bid, seller)
    @bid = bid
    @seller = seller
    mail(to: @seller.email, subject: "Counter Offer has been made for you bid on #{@bid.company.name}")
  end

  def your_offer_win(bid)
    @bid = bid
    mail(to: @bid.user.email, subject: "Counter Offer has been made for you bid on #{@bid.company.name}")
  end

  def get_funded(company, email, last_name, first_name, country, phone, address, website, city, state, zipcode, timeframe, month_created, year_created, number_employees, two_line_summary, business_summary, market_of_customers, customer_problem, current_customers, solution, market_strategy, business_modal, competitors, qualifications, barriers, executive_summary_file, investor_slide_file, round_name, burn_rate, previous_capital, current_revenue, amout_seeking, esimated_valuation, exit_strategy)
    @company = company, @email = email, @last_name = last_name, @first_name = first_name, @country = country, @phone = phone, @address = address, @website = website, @city = city, @state = state, @zipcode = zipcode, @timeframe = timeframe, @month_created = month_created, @year_created = year_created, @number_employees = number_employees, @two_line_summary = two_line_summary, @business_summary = business_summary, @market_of_customers = market_of_customers, @customer_problem = customer_problem, @current_customers = current_customers, @solution = solution, @market_strategy = market_strategy, @business_modal = business_modal, @competitors = competitors, @qualifications = qualifications, @barriers = barriers, @executive_summary_file = executive_summary_file, @investor_slide_file = investor_slide_file, @round_name = round_name, @burn_rate = burn_rate, @previous_capital = previous_capital, @current_revenue = current_revenue, @amout_seeking = amout_seeking, @esimated_valuation = esimated_valuation, @exit_strategy =  exit_strategy
    attachments[executive_summary_file.original_filename] =   File.read(executive_summary_file.path)
    attachments[investor_slide_file.original_filename] =  File.read(investor_slide_file.path)
    mail(to: 'info@dreamfunded.com', subject: 'Get Funded Request')
  end
end
