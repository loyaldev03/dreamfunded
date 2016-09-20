class TestPdfForm < FillablePdfForm

  def initialize(info)
    @info = info
    super()
  end

  protected

  def fill_out

    [ :name, :state, :address, :website, :type_of_securtity, :max_amount, :company_location_address,
     :company_location_city, :company_location_state, :company_location_zipcode, :days, :legal_name,
     :position_title, :first_date, :prev_emp, :prev_title, :prev_dates, :prev_resp, :offering_purpose, :fin_condition
     ].each do |field|
      fill field, @info.send(field)
    end
    fill :date, @info.date_formed

    fill :security_holder, @info.principal_holders.last.name
    fill :class_of_securities, @info.principal_holders.last.securities_held
    fill :voting_power, @info.principal_holders.last.voting_power
    fill :type_of_security, @info.type_of_securtity
    fill :deadline, @info.dead_line


  end
end

