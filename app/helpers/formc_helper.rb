module FormcHelper

    def net_minimum_offering_amount(form_c_info)
        min_amount = form_c_info.fundraise_tiers.first.amount.to_f
        realty_returns_cut  = min_amount.to_f * 0.05
        net_value = min_amount - realty_returns_cut
        '$' + dollar_format(net_value)
    end

end
