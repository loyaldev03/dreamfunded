Raygun.setup do |config|
  config.api_key = "P39CEgV0o7dahJ3lijWHaA=="
  config.filter_parameters = Rails.application.config.filter_parameters

  # The default is Rails.env.production?
  # config.enable_reporting = !Rails.env.development? && !Rails.env.test?
  config.affected_user_method = :current_user
  config.affected_user_identifier_methods << :name
end





