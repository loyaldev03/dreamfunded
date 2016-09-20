class TestPdfForm < FillablePdfForm

  def initialize(info)
    @info = info
    super()
  end

  protected

  def fill_out

    [ :name, :state, :address, :website, :type_of_securtity, :max_amount, :company_location_address,
     :company_location_city, :company_location_state, :company_location_zipcode, :days, :legal_name, :dead_line,
     :position_title, :first_date, :prev_emp, :prev_title, :prev_dates, :prev_resp, :offering_purpose, :fin_condition
     ].each do |field|
      fill field, @info.send(field)
    end

    fill :date, @info.date_formed
    fill :type_of_security, @info.type_of_securtity
    #fill :deadline, @info.dead_line

    fill :security_holder_0, @info.principal_holders.first.try(:name)
    fill :class_of_securities_0, @info.principal_holders.first.try(:securities_held)
    fill :voting_power_0, @info.principal_holders.first.try(:voting_power)

    fill :security_holder_1, @info.principal_holders.second.try(:name)
    fill :class_of_securities_1, @info.principal_holders.second.try(:securities_held)
    fill :voting_power_1, @info.principal_holders.second.try(:voting_power)

    fill :security_holder_2, @info.principal_holders.third.try(:name)
    fill :class_of_securities_2, @info.principal_holders.third.try(:securities_held)
    fill :voting_power_2, @info.principal_holders.third.try(:voting_power)

    fill :security_holder_3, @info.principal_holders.fourth.try(:name)
    fill :class_of_securities_3, @info.principal_holders.fourth.try(:securities_held)
    fill :voting_power_3, @info.principal_holders.fourth.try(:voting_power)

  end
end

