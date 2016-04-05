class LiquidateShare < ActiveRecord::Base

  def total_shares
    name = self.company
    where(company: name).pluck(:number_shares).sum
  end

  def average_share_price
    LiquidateShare.all.pluck(:shares_price, :number_shares).map!{|a| a[0]*a[1]}.sum/LiquidateShare.all.pluck(:number_shares).sum
  end
end
