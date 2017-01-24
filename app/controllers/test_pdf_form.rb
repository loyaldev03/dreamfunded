class TestPdfForm < FillablePdfForm

  def initialize(info)
    @info = info
    super()
  end

  protected

  def fill_out

    [:name, :kind, :state, :address, :website, :type_of_securtity, :max_amount, :website,
     :days, :legal_name, :dead_line, :position_title, :first_date, :competition, :phone, :business_plan, :ceo,
     :prev_emp, :prev_title, :prev_dates, :prev_resp, :offering_purpose, :fin_condition, :maket_strategy, :discount, :customer_base,
     :price_of_securities, :number_of_securities, :min_amount, :min_investment, :product_description, :company_description,
     :rds, :rds_years, :upcoming_rd, :real_estate, :litigation,
     :valuation, :burn_rate, :has_material_capital, :material_capital, :material_capital_expenditures,
     :transactin, :related_person, :conflicts
     ].each do |field|
      fill field, @info.send(field)
    end

    fill :date_today, Time.new.strftime("%b %d %Y")
    fill :date_next_year, (Date.today + 1.year).strftime("%b %d %Y")

    fill :address, @info.address
    fill :category, @info.company.campaign.category
    fill :date, @info.date_formed
    fill :type_of_security, @info.type_of_securtity
    fill :num_of_employees, @info.company.campaign.employees_numer
    fill :deadline, @info.dead_line

    fill :team_names, @info.team_names
    fill :team_titles, @info.team_titles
    fill :additional_financing, @info.addit_financing
    fill :additional_sources_capital, @info.add_sources_capital
    fill :additional_sources_necessary, @info.add_sources_necessary

    fill :has_material_capital, @info.has_material_captl
  end
end

