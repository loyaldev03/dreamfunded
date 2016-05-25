module InvestHelper

  def company_price(company)
    number_with_precision(company.suggested_target_price, :precision => 2)
  end
end
