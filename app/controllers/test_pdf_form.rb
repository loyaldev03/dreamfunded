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

    if @info.officers.first
        fill :officer_name_1, @info.officers.first.name
        fill :officer_position_1, @info.officers.first.position
        fill :officer_education_1, @info.officers.first.education
        fill :officer_employment_1, @info.officers.first.employment
    end

    if @info.officers.second
        fill :officer_name_2, @info.officers.second.name
        fill :officer_position_2, @info.officers.second.position
        fill :officer_education_2, @info.officers.second.education
        fill :officer_employment_2, @info.officers.second.employment
    end

    if @info.officers.third
        fill :officer_name_3, @info.officers.third.name
        fill :officer_position_3, @info.officers.third.position
        fill :officer_education_3, @info.officers.third.education
        fill :officer_employment_3, @info.officers.third.employment
    end
  end
end

