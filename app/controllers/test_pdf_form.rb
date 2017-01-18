class TestPdfForm < FillablePdfForm

  def initialize(info)
    @info = info
    super()
  end

  protected

  def fill_out

    [:name, :kind, :state, :address, :website, :type_of_securtity, :max_amount, :website,
     :days, :legal_name, :dead_line, :position_title, :first_date,
     :prev_emp, :prev_title, :prev_dates, :prev_resp, :offering_purpose, :fin_condition, :maket_strategy,
     :price_of_securities, :number_of_securities, :min_amount, :min_investment, :product_description, :company_description
     ].each do |field|
      fill field, @info.send(field)
    end

    fill :date_today, Time.new.strftime("%b %d %Y")
    fill :date_next_year, (Date.today + 1.year).strftime("%b %d %Y")

    fill :address, @info.address
    fill :date, @info.date_formed
    fill :type_of_security, @info.type_of_securtity
    fill :num_of_employees, @info.company.campaign.employees_numer
    fill :deadline, @info.dead_line

  end
end

