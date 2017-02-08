class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :company


  def fund_america_invested_amount
    if self.fund_america_id
        investment_code = self.fund_america_id
        begin
         p "PULLING FundAmerica API"
          investment =  FundAmerica::Investment.details(investment_code)
          return  investment["amount"]
        rescue JSON::ParserError => e
          puts e
          puts 'ERROR'
          return 'TBA'
        rescue FundAmerica::Error => e
          # Print response from FundAmerica API in case of unsuccessful response
          puts e.parsed_response
        else
          invested_amount
        end
    else
        invested_amount
    end
  end

end
