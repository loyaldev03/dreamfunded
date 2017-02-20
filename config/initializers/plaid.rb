Plaid.config do |p|
  p.customer_id = Rails.application.secrets.plaid_client_id
  p.secret =  Rails.application.secrets.plaid_secret
  # p.environment_location = Rails.env.production? ? 'https://api.plaid.com/' : 'https://tartan.plaid.com/'
  p.environment_location = 'https://api.plaid.com/'
end
PlaidRails.configure do |config|
  config.public_key =  Rails.application.secrets.plaid_public_key
  config.longtail = true
  # config.env =  Rails.env.production? ? "production" : "tartan"
  config.env =  "production"
  config.webhook = 'https://my.app.com/plaid/webhooks'
  
  # https://plaid.com/docs/#webhook
  #subscribe to plaid webhooks
  config.all do |event|
    Rails.logger.debug "Plaid Webhook: #{event.inspect}"
  end
  
  config.subscribe "transactions.initial" do |event|
    Rails.logger.debug "transactions.initial #{event.inspect}"
    # do something with intial transactions
  end
  config.subscribe "transactions.new" do |event|
    Rails.logger.debug "transactions.new #{event.inspect}"
    # do something with the new transactions
  end
  config.subscribe "transactions.interval" do |event|
    Rails.logger.debug "transactions.initial #{event.inspect}"
    # do something with the new transactions
  end
end
