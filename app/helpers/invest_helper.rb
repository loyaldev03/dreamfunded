module InvestHelper

  def company_price(company)
    number_with_precision(company.suggested_target_price, :precision => 2)
  end

  def maximum_investment(investor)


    income = investor.annual_income
    net_worth = investor.new_worth

    min = income < net_worth ? income : net_worth

    if min < 100000
      allowed_to_invest = min * 0.05
      allowed_to_invest = allowed_to_invest > 2000 ? allowed_to_invest : 2000
    elsif min > 100000
      allowed_to_invest = min * 0.1
    end
    allowed_to_invest
  end
end
